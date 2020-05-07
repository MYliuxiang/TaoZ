//
//  JPushHelper.swift
//  YJKApp
//
//  Created by admin on 2020/3/30.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

class JPushHelper: NSObject {
    
    
    static var defaultIAPHelper :JPushHelper{
         struct Single{
             static  let defaultIAPHelper = JPushHelper()
         }
         return Single.defaultIAPHelper
    }
    
     //*******************************  注册极光 **********************************
     func register(application: UIApplication,launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
         
         //极光推送部署
         let entity = JPUSHRegisterEntity()
         entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.badge.rawValue)
         JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
         JPUSHService.setup(withOption: launchOptions, appKey: JPAppKey, channel: "Publish channel", apsForProduction: true)
         JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
             if resCode == 0{
                 print("registrationID获取成功：\(registrationID ?? "")")
             }else {
                 print("registrationID获取失败：\(registrationID ?? "")")
             }
         }
         
         //进入应用角标清零
         application.applicationIconBadgeNumber = 0
         bind_account()
         
     }
     
     ///绑定极光推送账号
     func bind_account() {
         
//         if UserDefaults.standard.bool(forKey: userDefaults_isLogin) == true {
//          JPUSHService.setAlias(UserInfoModel.loadUserInfo()?.uid, completion: { (iResCode, iAlias, seq) in
//             print("*********绑定极光别名-->iResCode:\(iResCode),aliasString:\(UserInfoModel.loadUserInfo()?.uid ?? "")")
//          }, seq: 0)
//         } else {
//             unBind_account()
//         }
         
     }
     
     ///解绑极光推送账号
     func unBind_account() {
         
         JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in
             print("*********取消绑定极光别名-->iResCode:\(iResCode)")
         }, seq: 0)
         
     }
    
    ///设置BadgeNumber
      func resetIconBadgeNumber(application: UIApplication){
          JPUSHService.resetBadge()
          application.applicationIconBadgeNumber = 0
      }
    
      ///registerDeviceToken
      func registerDeviceToken(deviceToken: Data){
           JPUSHService.registerDeviceToken(deviceToken)
      }
      
      ///收到静默推送的回调
      func handleRemoteNotification(userInfo: [AnyHashable : Any]){
            JPUSHService.handleRemoteNotification(userInfo)
            print("收到通知:\(userInfo)")
      }

}

//极光的代理
extension JPushHelper: JPUSHRegisterDelegate
{
    
    //APP外点击通知栏响应
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        JPUSHService.resetBadge()
        let userInfo = response.notification.request.content.userInfo
        print("APP外点击通知栏响应收到通知:\(userInfo)")
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:
        {
    
        })
          
    }
    
    //app内通知响应
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        JPUSHService.resetBadge()
        let userInfo = notification.request.content.userInfo as NSDictionary
        print("APP内通知响应收到通知:\(userInfo)")
        //        let alert = (userInfo["aps"]! as! NSDictionary)["alert"] as! NSDictionary
        //        let body = (alert["body"]!) as! String
        //        let title = (alert["title"]!) as! String
        //        let content = title + ":" + body
        //        EBBannerView.show(withContent: content)
        
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
    
    }
    
}
