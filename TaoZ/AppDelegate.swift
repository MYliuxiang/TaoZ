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
    static let app: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //注册相关服务
        AppService.shareInstance.registerAppService(application: application, launchOptions: launchOptions)
       
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let tabBar = TabBarObject.shareInstance.setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        
        self.window?.rootViewController = tabBar
        self.window?.backgroundColor = UIColor.red
           
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

  

}

