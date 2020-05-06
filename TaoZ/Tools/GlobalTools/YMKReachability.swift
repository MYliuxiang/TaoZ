//
//  YMKReachability.swift
//  GDDZ
//
//  Created by YMK on 2019/7/19.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit
import Reachability

class YMKReachability: NSObject {
    
    var reachabilityChangedblock:((Reachability) ->Void)?
    let reachability = try! Reachability()
    
    static var defaultIAPHelper :YMKReachability{
        struct Single{
            static  let defaultIAPHelper = YMKReachability()
        }
        return Single.defaultIAPHelper
    }
    

    //开启网络监测
    func reachability_startNotifier() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    //关闭网络监听
    func reachability_stopNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        if self.reachabilityChangedblock != nil
        {
            self.reachabilityChangedblock!(reachability)
        }
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
