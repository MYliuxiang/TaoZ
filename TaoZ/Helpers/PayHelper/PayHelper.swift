//
//  PayHelper.swift
//  YJKApp
//
//  Created by YJK on 2020/3/13.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

public typealias AliPayResult = ((_ payResult:Bool?,_ errStr:String?,_ resultStr:String?) ->Void)
public typealias WxPayResult = ((_ errCode: Int,_ errStr:String?) ->Void)

class PayHelper: NSObject {
    
    var aliPayResult: AliPayResult?
    var wxPayResult: WxPayResult?
    
    static var defaultIAPHelper :PayHelper{
         struct Single{
             static  let defaultIAPHelper = PayHelper()
         }
         return Single.defaultIAPHelper
    }
    
    
    /// 打开支付宝支付
    /// - Parameters:
    ///   - orderString: 订单数据
    ///   - schemeString: schemeString
    ///   - aliPayResult: 支付结果返回
    func openAliPay(orderString:String,schemeString:String = "apppayJZYZ",aliPayResult:AliPayResult?) {
       
        self.aliPayResult = aliPayResult
        
        AlipaySDK.defaultService().payOrder(orderString, fromScheme: schemeString) { (resultDic) in
             
            LLog("支付宝结果返回 :\(resultDic ?? [:])");
            self.handleAliPayResult(resultDic: resultDic! as NSDictionary)

         }
    }
    
    //支付宝支付结果处理
    func handleAliPayResult(resultDic:NSDictionary)  {
        let resultStr = resultDic["result"] as? String
        var memo = resultDic["memo"] as? String
        let resultStatus = Int(resultDic["resultStatus"] as? String ?? "0")
        switch resultStatus {
        case 6001:
            memo = "用户取消支付";
            break;
            
        case 8000:
            memo = "正在处理中，等待商家确认";
            break;
            
        case 4000:
            memo = "订单支付失败";
            break;
            
        case 6002:
            memo = "网络连接出错";
            break;
            
        default:
            memo = "支付失败";
            break;
        }
        let payResult:Bool = resultStatus == 9000
        if self.aliPayResult != nil
        {
            self.aliPayResult!(payResult,memo,resultStr)
        }
        
    }
    

    /// 打开微信支付
    /// - Parameters:
    ///   - orderDic: 订单数据
    ///   - wxPayResult: 支付结果返回
    func openWxPay(orderDic:Dictionary<String, Any>,wxPayResult:WxPayResult?) {
         
          self.wxPayResult = wxPayResult
          
          if orderDic.keys.count <= 0 {
                  return
          }
          let dic = orderDic as! Dictionary<String,String>
          let req = PayReq()
          req.nonceStr = dic["noncestr"]
          req.partnerId = dic["partnerid"]
          req.prepayId = dic["prepayid"]
          req.openID = dic["appid"]
          req.timeStamp  = uint_fast32_t(dic["timestamp"] ?? "0")!
          req.package = dic["package"]
          req.sign = dic["sign"]
          WXApi.send(req)

      }
    
    
    /// 处理支付完成（成功或者失败）
    /// - Parameter url: 回调的url
    func payForResults(url:URL) {
        
        //支付宝支付
        if url.host == "safepay" {
              //跳转支付宝钱包进行支付，处理支付结果
              AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: {
                  (resultDic) -> Void in
                  //调起支付结果处理
                   LLog(" 客户端支付宝支付结果------>\(resultDic! as NSDictionary) ")
                  //支付成功
                  if (resultDic?["resultStatus"] as? String) == "9000"
                  {
                      LLog("支付宝支付成功")
                  }
              })
          }
        
        // 微信支付
        if (url.scheme?.contains(WXAppid) ?? false) && (url.host?.contains("pay") ?? false)
        {
            WXApi.handleOpen(url, delegate: PayHelper.defaultIAPHelper)
        }
        
    }
    
}

extension PayHelper:WXApiDelegate
{
    
        //微信分享完毕后的回调（只有使用真实的AppID才能收到响应
        func onResp(_ resp: BaseResp!)
        {
            
//            if resp.isKind(of:SendMessageToWXResp.self){//确保是对我们分享操作的回调
//                if resp.errCode == WXSuccess.rawValue
//                {//分享成功
//                } else {//分享失败
//
//                }
//            }

//            if resp.isKind(of:SendAuthResp.self)
//            {
//                if resp.errCode == WXSuccess.rawValue
//                {//登录成功
//                } else {//登录失败
//                }
//            }
            
            //支付回调
            if resp.isKind(of:PayResp.self)
            {
                if (self.wxPayResult != nil)
                {
                    self.wxPayResult!(Int((resp?.errCode)!),resp?.errStr)
                }
            
            }
        }
        
        func onReq(_ req: BaseReq!) {
        }
    
}
