////
////  YMKPushTool.swift
////  YMKForB
////
////  Created by YMK on 2019/9/19.
////  Copyright © 2019 ymk. All rights reserved.
////
//
//import UIKit
//
//class PushModel: BaseModel {
//    var aps :ApsModel?//
//    var pushType :Int?//推送类型 1链接 2原生,3打开APP
//    var pushUrl :String?//推送URL 跳转H5页面
//    var jumpAppType :Int?//跳转原生类型
//    var jumpAppParameter :JumpAppParameterModel? //跳转原生参数（页面参数）{“id”:1,”type”:”xx”…..}
//}
//
//class ApsModel: BaseModel {
//    var alert :AlertModel?//id
//}
//
//class AlertModel: BaseModel {
//    var body :String?
//    var title :String?
//}
//
//class JumpAppParameterModel: BaseModel {
//    var id :String?//id
//}
//
//class YMKPushTool: NSObject {
//    
//   var alertvc:UIAlertController!//通知弹窗
//    
//   static var defaultIAPHelper :YMKPushTool{
//        struct Single{
//            static  let defaultIAPHelper = YMKPushTool()
//        }
//        return Single.defaultIAPHelper
//    }
//
//    //获取各个环境下账号的区分
//   class func getBindAccount(IDString:String) -> String {
//        
//        var typeString = ""
//        //正式环境
//        if Domain_Url.contains("ymk.emeik") == true {
//            typeString = "ymk_user"
//        }
//        
//        //验收环境
//        if Domain_Url.contains("ymk-uat") == true {
//            typeString = "ymk_uat_user"
//        }
//        
//        //正式环境
//        if Domain_Url.contains("ymk-beta") == true {
//            typeString = "ymk_beta_user"
//        }
//    
//        if IDString == ""{
//            return typeString
//        } else {
//            return "\(typeString)_\(IDString)"
//        }
//
//    }
//    
//    
//    //dic推送消息内容  isAlert是否有弹框
//    func pushAPNAlert(dic:[String:Any]?,isAlert:Bool) {
//        
//        print("******推送消息: \(String(describing: dic))");
//        weak var weakSelf = self
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.35, execute: //加定时器的目的是为了给app启动时间
//            {
//                if isAlert == true {
//                    
//                    if weakSelf?.alertvc != nil{
//                        weakSelf?.alertvc.dismiss(animated: true, completion: nil)
//                    }
//                    
//                    let model = PushModel.deserialize(from: dic)
//                    weakSelf?.alertvc = UIAlertController(title: model?.aps?.alert?.title ?? "", message: model?.aps?.alert?.body ?? "", preferredStyle: UIAlertController.Style.alert)
//                    let cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.default) { (action) in
//                        
//                    }
//                    let sure = UIAlertAction.init(title: "去看看", style: UIAlertAction.Style.default) { (action) in
//                        weakSelf?.push_action(dic: dic)
//                    }
//                    
//                    weakSelf?.alertvc.addAction(cancel)
//                    weakSelf?.alertvc.addAction(sure)
//                    
//                    let currentCtl = UIViewController.currentViewController()
//                    currentCtl?.present((weakSelf?.alertvc)!, animated: true, completion: nil)
//                    
//                } else {
//                    
//                    weakSelf?.push_action(dic: dic)
//                }
//                
//        })
//        
//    }
//    
//    func push_action(dic:[String:Any]?) {
//        
//        //pushType 1链接 2原生,3打开APP
//        let model = PushModel.deserialize(from: dic)
//        if model?.pushType == 1 {
//            
//            AppService.shareInstance.gotoHome()
//            let url =  URL.init(string: model?.pushUrl ?? "")
//            if url != nil {
//                WebViewHelper.webView.load(URLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20))
//            }
//    
//        }
//        
//        if model?.pushType == 2 {
//            
//            
//        }
//        
//        
//    }
//    
//    
//}
