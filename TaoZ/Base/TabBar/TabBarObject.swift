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
//        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
//        tabBarController.tabBar.backgroundImage = UIImage(named: "tabbar_background")
        
        let lessonsVC = LessonsVC()
        let diaiogueVC = DiaiogueVC()
        let skillsVC = SkillsVC()
        let meVC = MeVC()
        
         lessonsVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "Lessons", image: UIImage(named: "lesson_未选中"), selectedImage: UIImage(named: "lesson_选中"))
         diaiogueVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "Dialogue", image: UIImage(named: "Dialogue_未选中"), selectedImage: UIImage(named: "Dialogue_选中"))
        
         skillsVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "Skills", image: UIImage(named: "Skills_未选中"), selectedImage: UIImage(named: "Skills_选中"))
         meVC.tabBarItem = ESTabBarItem.init(TabBarIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me_未选中"), selectedImage: UIImage(named: "me_选中"))
        
          let homeNav = BaseNavigationController.init(rootViewController: lessonsVC)
          let lifeCircleNav = BaseNavigationController.init(rootViewController: diaiogueVC)
        
          let cityMerchantsNav = BaseNavigationController.init(rootViewController: skillsVC)
          let myNav = BaseNavigationController.init(rootViewController: meVC)
          tabBarController.viewControllers = [homeNav,lifeCircleNav,cityMerchantsNav,myNav]
        
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
