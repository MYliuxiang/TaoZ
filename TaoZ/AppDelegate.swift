//
//  AppDelegate.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isForceLandscape = false//是否允许横屏
    var allowOrentitaionRotation:Bool! = false
    static let app: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //注册相关服务
        AppService.shareInstance.registerAppService(application: application, launchOptions: launchOptions)
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = TabBarObject.shareInstance.setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
        if !UserDefaultsStandard.bool(forKey: isLogin) {
           let nav = BaseNavigationController(rootViewController: LoginVC())
            nav.modalPresentationStyle = .fullScreen
            tabBar.present(nav, animated: false, completion: nil)
        }
        
        return true
    }

    //MARK:************* 将要进入后台 ****************
      func applicationWillResignActive(_ application: UIApplication) {
          // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
          // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
      }
      
      //MARK:************* 已经进入后台 ****************
      func applicationDidEnterBackground(_ application: UIApplication) {
          // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
          // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      }
      
      //MARK:************* 将要进入前台 ****************
      func applicationWillEnterForeground(_ application: UIApplication) {
          // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
          JPushHelper.defaultIAPHelper.resetIconBadgeNumber(application: application)
         
      }
      
      //MARK:************* 已经活跃 ****************
      func applicationDidBecomeActive(_ application: UIApplication) {
          // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
      }
      
      //MARK:************* 将要推出程序 ****************
      func applicationWillTerminate(_ application: UIApplication) {
          // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      }
      
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           
          JPushHelper.defaultIAPHelper.registerDeviceToken(deviceToken:deviceToken)
         
       }
      
      /**
       收到静默推送的回调
       
       @param application  UIApplication 实例
       @param userInfo 推送时指定的参数
       @param completionHandler 完成回调
       */
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          
          JPushHelper.defaultIAPHelper.handleRemoteNotification(userInfo: userInfo)
          JPushHelper.defaultIAPHelper.resetIconBadgeNumber(application: application)
          completionHandler(UIBackgroundFetchResult.newData)
      }

      func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          
          let result =  UMSocialManager.default().handleOpen(url, options: options)
          if result == true {
              return result
          }
          
         //支付回调
          PayHelper.defaultIAPHelper.payForResults(url: url)
          
          return true
      }
      
//      /// 设置屏幕支持的方向
//       func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//           if isForceLandscape {
//               return .all
//           }
//           return .portrait
//           
//       }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowOrentitaionRotation! {
            return .allButUpsideDown
        }else{
            return .portrait
        }
    }

}




