//
//  MyNetworkActivityPlugin.swift
//  NN110
//
//  Created by 陈亦海 on 2017/5/10.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation


/// Network activity change notification type.
public enum MyNetworkActivityChangeType {
    case began, ended
}



public final class LxCustomPlugin: PluginType {
    
    
    public typealias MyNetworkActivityClosure = (_ change: MyNetworkActivityChangeType, _ target: TargetType) -> Void
    let myNetworkActivityClosure: MyNetworkActivityClosure
    var hud:MBProgressHUD?
    public init(newNetworkActivityClosure: @escaping MyNetworkActivityClosure) {
        self.myNetworkActivityClosure = newNetworkActivityClosure
    }
    
    // MARK: Plugin
    
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        
        let api = target as! NetAPIManager

        if api.show{
                   DispatchQueue.main.async {
                    self.hud =  MBProgressHUD.showAdded(to: keywindow, animated: true)
                   }
               }
        
        myNetworkActivityClosure(.began,target)
    }
      
    
    public func didReceive(_ result: Swift.Result<Response, MoyaError>, target: TargetType) {
        
        self.hud?.hide(true)
        myNetworkActivityClosure(.ended,target)
    }
    
   
        
   
}

