//
//  ThirdloginHelper.swift
//  YJKApp
//
//  Created by YJK on 2020/3/11.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

/*
 {
     "client_id": "com.yjk.test" //"实际上被称为“Service ID”，您将在“Identifiers”部分创建它，其实就是应用的bundleID",
     "team_id": "49RMD2WMA5" //"后台账号的teamID",
     "redirect_uri": "重定向url，网页登录需要，只是客服端登录可以不写",
     "key_id": "4RG9FCXGGU" //"在苹果后台获取，如下图",
     "scope": "设置我们要从用户那里收集什么信息，我们可以设置email和name，或者也可以不写
 }
 
 */

//MARK:  授权平台
enum EnumLoginType: Int
{
    /// 1 微信登录
    case weixin = 1
    /// 2 QQ登录
    case qq = 2
    /// 3 微博
    case weibo = 3
    /// 4 apple登录
    case apple = 4
}


// MARK: apple授权数据返回
class AppleIDCredential: NSObject {
      ///苹果用户唯一标识符，该值在同一个开发者账号下的所有App下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起
      var userIdentifier: String?
      ///名字
      var name: String?
      ///邮箱
      var email: String?
      /// 服务器验证需要使用的参数
      var identityTokenStr: String?
      var authorizationCodeStr: String?
}

class ThirdloginHelper: NSObject {
    
    static var defaultIAPHelper :ThirdloginHelper{
          struct Single{
              static  let defaultIAPHelper = ThirdloginHelper()
          }
          return Single.defaultIAPHelper
    }
    
    public typealias SuccessHandler = ((_ resp:UMSocialUserInfoResponse?,_ appleIDCredential:AppleIDCredential?) ->Void)
    public typealias FailtureHandler = ((_ message: String) ->Void)
    
    var success: SuccessHandler?
    var failture: FailtureHandler?
    
    
    /// 第三方登录
    /// - Parameters:
    ///   - loginType: 登录类型
    ///   - successClourse: 成功返回
    ///   - failClourse: 失败返回
    func loginGetUserInfo(loginType:EnumLoginType,successHandler:SuccessHandler? ,failtureHandler:FailtureHandler?) {
        
          success = successHandler
          failture = failtureHandler
        
        //启用其他平台授权
        if loginType != .apple {
            
            let platformType:UMSocialPlatformType = loginType == .weixin ? .wechatSession : loginType == .qq ? .QQ : .sina
                     
             UMSocialManager.default()?.getUserInfo(with: platformType, currentViewController: nil, completion: { (result, error) in
                    
                    if (error != nil){
                        if self.failture != nil
                        {
                            self.failture!("授权失败")
                        }
                       
                        SVProgressHUD.showError(withStatus: "授权失败")
                        return
                    }
                    
                    let resp =  result as! UMSocialUserInfoResponse
                
                    if self.success != nil
                    {
                        self.success!(resp,nil)
                    }
                    
                    // 授权数据
                    print("*********第三方登录: \(resp.originalResponse ?? "")")//第三方平台SDK原始数据
                    

                })
            
        }
        
        //启用apple授权
        if loginType == .apple {
            
             handleAuthorizationAppleID()
        }

        
    }
    
    //启用apple授权
    func handleAuthorizationAppleID() {
            if #available(iOS 13.0, *) {
                       
               // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
               let appleIDProvider = ASAuthorizationAppleIDProvider()
               // 创建新的AppleID 授权请求
               let request = appleIDProvider.createRequest()
               // 在用户授权期间请求的联系信息
               request.requestedScopes = [.fullName, .email]
               // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
               let authorizationController = ASAuthorizationController(authorizationRequests: [request])
               // 设置授权控制器通知授权请求的成功与失败的代理
               authorizationController.delegate = self
               // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
               authorizationController.presentationContextProvider = self
               // 在控制器初始化期间启动授权流
               authorizationController.performRequests()
               
               
           } else {
               // 处理不支持系统版本
                LLog("该系统版本不可用Apple登录");
           }
     
    }
    
    //该功能通过同时请求Apple ID和iCloud钥匙串密码来检查用户是否具有现有帐户
    func performExistingAccountSetupFlows() {
        // 已经认证过了
        if #available(iOS 13.0, *) {
            let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                            ASAuthorizationPasswordProvider().createRequest()]
            // Create an authorization controller with the given requests.
             let authorizationController = ASAuthorizationController(authorizationRequests: requests)
             authorizationController.delegate = self
             authorizationController.presentationContextProvider = self
             authorizationController.performRequests()
        }  else {
            // 处理不支持系统版本
            LLog("该系统版本不可用Apple登录");
        }
    }
    
}


extension ThirdloginHelper: ASAuthorizationControllerDelegate {
  
    //授权成功地回调
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    
        switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                //用户登录使用ASAuthorizationAppleIDCredential
                let userIdentifier = appleIDCredential.user //苹果用户唯一标识符，该值在同一个开发者账号下的所有App下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起
                // 使用过授权的，可能获取不到以下两个参数
                let fullName = appleIDCredential.fullName//全名
                let email = appleIDCredential.email//邮箱
                
                let identityToken = appleIDCredential.identityToken
                let authorizationCode = appleIDCredential.authorizationCode
            
               // 服务器验证需要使用的参数
                let identityTokenStr =  NSString(data: identityToken ?? Data(), encoding:String.Encoding.utf8.rawValue)
                let authorizationCodeStr =  NSString(data: authorizationCode ?? Data(), encoding:String.Encoding.utf8.rawValue)
                LLog("userIdentifier:\(userIdentifier),fullName:\(fullName?.givenName ?? "")\(fullName?.familyName ?? ""),email:\(email ?? ""),identityTokenStr:\(identityTokenStr ?? "") authorizationCodeStr:\(authorizationCodeStr ?? "")")
                
                let appleIDCredential = AppleIDCredential()
                appleIDCredential.userIdentifier = userIdentifier
                appleIDCredential.name = "\(fullName?.givenName ?? "")\(fullName?.familyName ?? "")"
                appleIDCredential.email = email
                appleIDCredential.identityTokenStr = identityTokenStr as String?
                appleIDCredential.authorizationCodeStr = authorizationCodeStr as String?
                
                  if self.success != nil
                  {
                    self.success!(nil,appleIDCredential)
                  }

                
//            case let passwordCredential as ASPasswordCredential:
                //这个获取的是iCloud记录的账号密码，需要输入框支持iOS 12 记录账号密码的新特性，如果不支持，可以忽略
//                let username = passwordCredential.user// 密码凭证对象的用户标识 用户的唯一标识
//                let password = passwordCredential.password// 密码凭证对象的密码
                
            
        default:
            break
        }
    }
    
    
    // 授权失败的回调
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
          LLog("Handle error：\(error)")
        SVProgressHUD.showError(withStatus: "授权失败")
         if self.failture != nil
         {
            self.failture!("授权失败")
         }
    }
   
    
    
}

// 告诉代理应该在哪个window 展示内容给用户
extension ThirdloginHelper: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return  UIApplication.shared.windows.last!
    }
}
