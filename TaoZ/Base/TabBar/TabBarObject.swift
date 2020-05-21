//
//  TabBarObject.swift
//  JZYZApp
//
//  Created by 李江 on 2020/2/23.
//  Copyright © 2020 李江. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarObject: NSObject {
    
    let tabBarController = ESTabBarController()
    
    static var shareInstance :TabBarObject{
        struct Single{
            static  let shareInstance = TabBarObject()
        }
        return Single.shareInstance
    }
    
     /// 1.加载tabbar样式
     ///
     /// - Parameter delegate: 代理
     /// - Returns: ESTabBarController
     func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController  {
        
        tabBarController.delegate = delegate
        tabBarController.tabBar.shadowImage = UIImage.init(color: .red, size: CGSize(width: ScreenWidth, height: 100))
        tabBarController.tabBar.backgroundImage = UIImage.init(color: .white, size: CGSize(width: ScreenWidth, height: 100))
        
        tabBarController.tabBar.backgroundColor = .white
        
        let homeVC = HomeVC()
        let discoverVC = DiscoverVC()
        let messagesVC = MessagesVC()
        let meVC = MeVC()
        
         homeVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "", image: UIImage(named: "tab_icon_home_default"), selectedImage: UIImage(named: "tab_icon_home_selected"))
         discoverVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "", image: UIImage(named: "tab_icon_dynamic_default"), selectedImage: UIImage(named: "tab_icon_dynamic_selected"))
        
         messagesVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "", image: UIImage(named: "tab_icon_information_default"), selectedImage: UIImage(named: "tab_icon_information_selected"))
         meVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "", image: UIImage(named: "tab_icon_mine_default"), selectedImage: UIImage(named: "tab_icon_mine _selected"))
        
          let homeNav = BaseNavigationController.init(rootViewController: homeVC)
          let discoverNav = BaseNavigationController.init(rootViewController: discoverVC)
        
          let messagesNav = BaseNavigationController.init(rootViewController: messagesVC)
          let myNav = BaseNavigationController.init(rootViewController: meVC)
          tabBarController.viewControllers = [homeNav,discoverNav,messagesNav,myNav]
        
        //当前item是否需要被劫持
        tabBarController.shouldHijackHandler = {
              tabbarController, viewController, index in
//              if index == 2 {
//                  return true
//              }
//
//            if index == 4 {
//                //未登录劫持
//                return !UserDefaults.standard.bool(forKey: userDefaults_isLogin)
//            }
              return false
          }
        
        //劫持的点击事件
        tabBarController.didHijackHandler = {
             tabbarController, viewController, index in
            
//            if index == 2 {
//
//                if YMKBasicTool.defaultIAPHelper.gotoLogin()! {
//
//                    let appPublishView = AppPublishView()
//                    appPublishView.show()
//                    appPublishView.clickedHandler = { (seletedIndex) in
//                        if seletedIndex == 1 {
//                            UIViewController.currentViewController()?.navigationController?.pushViewController(PublishVC(), animated: true)
//
//                        } else {
//                            UIViewController.currentViewController()?.navigationController?.pushViewController(PublishLifeCircleVC(), animated: true)
//                        }
//                    }
//
//                }
//            }
//
//            if index == 4 {
//
//                let _ = YMKBasicTool.defaultIAPHelper.gotoLogin()
//            }
        }
         
         return tabBarController

     }

}
