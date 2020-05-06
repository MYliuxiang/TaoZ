//
//  YMKDvice.swift
//  YiMeiKa
//
//  Created by ykm on 2018/4/16.
//  Copyright © 2018年 joyshops. All rights reserved.
//

import Foundation
import UIKit

class YMKDvice {
    
    //MARK:判断是否是刘海设备
    static func isIphoneX() -> Bool {
     return UIApplication.shared.statusBarFrame.size.height == 44
    }
    
    //MARK:导航栏高度
    static func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64
    }
    
    //MARK:状态栏高度
    static func statusBarHeight() -> CGFloat {
        return isIphoneX() ? 44 : 20
    }
    
    //MARK:标签栏高度
    static func tabBarHeight() -> CGFloat {
        return isIphoneX() ? 83 : 49
    }
    
    //MARK:上面安全区域高度
    static func topOffset() -> CGFloat {
        return isIphoneX() ? 28 : 0
    }
    
    //MARK:下面安全区域高度
    static func bottomOffset() -> CGFloat {
        return isIphoneX() ? 34 : 0
    }
    
}



