//
//  AppService.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class AppService: NSObject {

    static var shareInstance :AppService{
           struct Single{
               static  let shareInstance = AppService()
           }
           return Single.shareInstance
       }
    
    //注册相关服务
    func registerAppService(application: UIApplication,launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        
        //注册融云
        RCIM.shared()?.initWithAppKey(RcimKey)
        //连接IM
        RCIM.shared()?.connect(withToken: RcimToken, dbOpened: { (code) in
        }, success: { (userID) in
            
        }, error: { (status) in
            
        }, tokenIncorrect: {
            
        })
        
        
        //注册buggly
        Bugly.start(withAppId: BuglyID)
        
        ///注册keyboardManager
        register_keyboardManager()
        
        ///注册网络监听(只需开始一次)
        register_reachability()
        
        ///设置导航栏
        setNavBarAppearence()
        
        ///注册微信
        WXApi.registerApp(WXAppid)
        
        ///注册友盟
        register_UMSocial()
        
        ///注册极光推送
               
        JPushHelper.defaultIAPHelper.register(application: application, launchOptions: launchOptions)
        
        ///设置字体适配大小
//        SwiftyFitsize.reference(width: 375, iPadFitMultiple: 0.5)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setErrorImage(UIImage(named: "") ?? UIImage())
        SVProgressHUD.setSuccessImage(UIImage(named: "") ?? UIImage())

        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.6))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.setMinimumDismissTimeInterval(0.35)
        
        var style = ToastStyle()
        style.messageFont = .systemFont(ofSize: 14)
        
        ToastManager.shared.style = style

        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.35, execute:
            {
                //检测更新 大于等于两个版本会强制更新
                self.UpdataAppStoreVersion()
        })
    }
    
    //*******************************  注册友盟  **********************************
     private func register_UMSocial() {
          
          UMSocialManager.default().openLog(false)
          UMConfigure.initWithAppkey(UMShareKey, channel: "App Store")
          
          UMSocialGlobal.shareInstance().isUsingHttpsWhenShareContent = false//可以用非https的图片
          
          UMSocialManager.default().setPlaform(.wechatSession, appKey: WXAppid, appSecret: WXSecret, redirectURL:RedirectURL)
          UMSocialManager.default().setPlaform(.wechatTimeLine, appKey:WXAppid, appSecret: WXSecret, redirectURL:RedirectURL)
          UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: QQKey, appSecret: nil, redirectURL:nil)
          UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: SinaKey, appSecret: SinaSecret, redirectURL: "http://weibo.com/")
      
          //统计
          UMConfigure.initWithAppkey(UMShareKey, channel: "App Store")
          UMConfigure.setLogEnabled(false)
          UMConfigure.setEncryptEnabled(true)
          MobClick.setScenarioType(eScenarioType.E_UM_NORMAL)
          
      }
      
    
     private func register_keyboardManager(){
            
            //设置光标的颜色
//            UITextField.appearance().tintColor = color_999999
//            UITextView.appearance().tintColor = color_999999
            
            //键盘框架
            let keyboardManager = IQKeyboardManager.shared
            keyboardManager.enable = true //控制自动键盘处理事件在整个项目内是否启用
            keyboardManager.shouldResignOnTouchOutside = true//控制点击背景收起键盘
            keyboardManager.enableAutoToolbar = true //是否显示键盘上的工具条
            keyboardManager.shouldToolbarUsesTextFieldTintColor = true
            keyboardManager.keyboardDistanceFromTextField = 0 //设置工具条与输入框之间的距离,默认距离是10
            //        keyboardManager.toolbarDoneBarButtonItemText = "收起"
            keyboardManager.toolbarDoneBarButtonItemImage = UIImage(named: "icon_xiala_gray")
            
        }
        
        //*******************************  注册网络监测  **********************************
        private func register_reachability()
        {
            YMKReachability.defaultIAPHelper.reachability_startNotifier()
            YMKReachability.defaultIAPHelper.reachabilityChangedblock = { (reachability) in
                switch reachability.connection {
                case .wifi:
                    print("当前处于WIFI状态")
                case .cellular:
                    print("当前处于手机网络状态")
                case .none:
                    print("无法识别")
                case .unavailable:
                    print("当前处于无网状态")
                }
            }
        }
        
        
        //*******************************  设置导航栏  **********************************
       private func setNavBarAppearence()
        {
            
            WRNavigationBar.wr_widely()
            // WRNavigationBar 不会对 blackList 中的控制器有影响
            WRNavigationBar.wr_setBlacklist(["TZPhotoPickerController",
                                             "TZImagePickerController",
                                             "TZGifPhotoPreviewController",
                                             "TZAlbumPickerController",
                                             "TZPhotoPreviewController",
                                             "TZVideoPlayerController"])
            WRNavigationBar.wr_setDefaultNavBarBarTintColor(.white)//导航栏颜色
            WRNavigationBar.wr_setDefaultNavBarTintColor(.black)//所有按钮的默认颜色
//            WRNavigationBar.wr_setDefaultNavBarTitleColor(color_2D2E36)//设置导航栏标题默认颜色
            WRNavigationBar.wr_setDefaultStatusBarStyle(.default)//设置状态栏样式
            WRNavigationBar.wr_setDefaultNavBarShadowImageHidden(false)//如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
            
            UITabBar.appearance().layer.borderWidth = 1
            UITabBar.appearance().clipsToBounds = true
            
        }
        
        
        //更新app
        func UpdataAppStoreVersion()
        {
            
            let localVersion = Bundle.appShortVersion()
//            NetworkHelper.POST(url: url_appVersion, params: ["phoneType":"1","appType":"2","versionCode":localVersion], ishud: false, success: { (result) in
//
//                if result["code"] as? Int == response_code_succes
//                {
//                    let data_dic:NSDictionary = result["data"] as! NSDictionary
//                    let appUpdateState = data_dic["appUpdateState"] as! Int
//
//                    // appUpdateState2 提示强制跟新，1可以更新 相差1-2个版本号，0不用更新版本号一致
//                    if appUpdateState == 1 || appUpdateState == 2 {
//
//    //                    let appVersionUpdataView = AppVersionUpdataView()
//    //                    appVersionUpdataView.appVersion =  data_dic["latestVersionCode"] as? String ?? ""
//    //                    appVersionUpdataView.appStoreUrl =  data_dic["appUrl"] as? String ?? ""
//    //                    appVersionUpdataView.isForceUpdate = appUpdateState == 2 ? true : false
//    //                    appVersionUpdataView.releaseNotes =  data_dic["releaseNotes"] as? String ?? "有新版本发布啦，快去更新体验！"
//    //                    appVersionUpdataView.show()
//
//                    }
//
//                }
//
//
//            }, failture: nil)
            
        }
        
        //跳转到首页
        func gotoHome() {
            
            let currentCtl = UIViewController.currentViewController()
            currentCtl?.dismiss(animated: false, completion: nil)
            let nav =  currentCtl as? BaseNavigationController
            let prevc = nav?.presentedViewController
            prevc?.dismiss(animated: false, completion: nil)
            nav?.popToRootViewController(animated: false)
            
        }
}
