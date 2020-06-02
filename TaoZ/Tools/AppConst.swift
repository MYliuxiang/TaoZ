//
//  AppConst.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//
import Foundation
import UIKit

///MARK:TODO 定义常用的类库信息, 使用@_exported关键字，就可以全局引入对应的包
@_exported import JXSegmentedView
@_exported import JXPagingView
//@_exported import ActiveLabel
//@_exported import HandyJSON
@_exported import Kingfisher
@_exported import SnapKit
@_exported import LXFProtocolTool
@_exported import SwiftyJSON
//@_exported import TextAttributes
@_exported import RxSwift
@_exported import RxCocoa
@_exported import InputKitSwift
@_exported import NSObject_Rx
@_exported import Toast_Swift
@_exported import CryptoSwift
@_exported import Moya
@_exported import Alamofire







//@_exported import CommonCrypto
import Kingfisher



// ************** 基本配置 ************************

let versionString = "1.0"

//融云id
let RcimKey = "bmdehs6pba6vs"

let RcimToken = "27bfb33270"



//bugglyID
let BuglyID = "27bfb33270"

//极光的appKeyA
let JPAppKey = "f7d12a0061cf620500fe2f43"


//友盟
let UMShareKey = "5ebe6bf4dbc2ec078b5be4ea"

//微信AppID
let WXAppid = "wxc807937e1003402a"
let WXSecret = "05b9c5cd53e186dbef325bf772e2409c"

let QQKey = "yvitPLV3Erb31mxN"//未有  tencent1109929039  QQ42282c4f
let QQAPPID = "1108218079"


let SinaKey = "152014725"//未有
let SinaSecret = "f721b8a668775b6b72209587ea5099a4"//未有
let RedirectURL = "redirectURL"


//基本属性
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let keywindow = UIApplication.shared.keyWindow!
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let screenFrame:CGRect = UIScreen.main.bounds

let ScareX = (ScreenWidth/375)
let ScareY = (ScreenHeight/667)

let APPVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]//app version
let DeviceId = UIDevice.current.identifierForVendor?.uuidString//设备id

//通知
let NotiCenter = NotificationCenter.default


//UserDefaults
let UserDefaultsStandard = UserDefaults.standard

let isLogin = "islogin"

let userDefaults_userInfo = "userDefaults_userInfo"//用户信息


//颜色

let color_theme = UIColor.colorWithHexStr("#FF3366")
let color_3 = UIColor.colorWithHexStr("#333333")
let color_6 = UIColor.colorWithHexStr("#666666")
let color_9 = UIColor.colorWithHexStr("#999999")


//通知
enum NotificationName: String {
    case loginSuccess// 用户登录成功
    case logout // 用户退出登录
    case launchAd  //广告
    case addCart  //广告
    case orderFresh
    case searchOrder
}

