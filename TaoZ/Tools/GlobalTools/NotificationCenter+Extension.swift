//
//  NotificationCenter+Extension.swift
//  YJKApp
//
//  Created by lijiang on 2020/3/2.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

extension NotificationCenter {
    
    class func post(name: NotificationName, object: Any? = nil , userInfo: [AnyHashable : Any]? = nil) {
        
        NotificationCenter.default.post(name: .customName(name: name),
                                        object: object,
                                        userInfo: userInfo)
        
    }

    class func post(name: Notification.Name, object: Any? = nil , userInfo: [AnyHashable : Any]? = nil) {

        NotificationCenter.default.post(name: name,
                                        object: object,
                                        userInfo: userInfo)
    }

    class func addObserver(observer: Any, selector: Selector, name: NotificationName, object: Any? = nil) {

        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: .customName(name: name),
                                               object: object)
        
    }

    class func addObserver(observer: Any, selector: Selector, name: Notification.Name, object: Any? = nil) {

        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: name,
                                               object: object)

    }
}

extension NSNotification.Name {

    static func customName(name: NotificationName) -> NSNotification.Name {
        
        return NSNotification.Name(name.rawValue)
    }

}

//enum NotificationName: String {
//
//    // 用户登录成功
//    case loginSuccess
//
//    // 用户退出登录
//    case logout
//
//}
