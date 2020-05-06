//
//  YMKBasicTool.swift
//  GDDZ
//
//  Created by YMK on 2019/7/10.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

class YMKBasicTool: NSObject {
    
    var isQuickclick = false //防止快递点击
    
    static var defaultIAPHelper :YMKBasicTool{
        struct Single{
            static  let defaultIAPHelper = YMKBasicTool()
        }
        return Single.defaultIAPHelper
    }
    
//    //跳转登录页
//    func gotoLogin()-> Bool?
//    {
//         let isLogin:Bool = UserDefaults.standard.bool(forKey: userDefaults_isLogin)
//         if !isLogin {
//            let rootVC = BaseNavigationController.init(rootViewController:  LoginVC())
//            rootVC.modalPresentationStyle = .fullScreen
//            UIViewController.currentViewController()?.present(rootVC, animated: true, completion: nil)
//        }
//        return isLogin
//    }
    
    ///获取APP缓存
    func getCacheSize()-> String {
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = cachePath! + ("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (key, fileSize) in floder {
                // 累加文件大小
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).integerValue
                }
            }
        }
        let totalCache = Double(size) / 1024.00 / 1024.00
        return String(format: "%.2f", totalCache)
    }


     ///删除APP缓存
    func clearCache(ishud:Bool? = true) {
       if ishud == true{
//            MBProgressHUD.showAdded(to: keywindow, animated: true)
        }
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
        
        if ishud == true{
//            MBProgressHUD.hide(for: keywindow, animated: true)
        }

    }

}

extension UIViewController {
    
    //获取当前的ViewController
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}


@IBDesignable extension CALayer {
    
    //xib设备边框
    @IBInspectable var borderColorWithUIColor: UIColor {
        get {
            return UIColor(cgColor: self.borderColor!)
        }
        set {
            self.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowUIColor: UIColor {
        get {
            return UIColor(cgColor: self.shadowColor!)
        }
        set {
            self.shadowColor = newValue.cgColor
        }
    }
    
    
    
}
