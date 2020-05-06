//
//  MyNetworkActivityPlugin.swift
//  NN110
//
//  Created by 陈亦海 on 2017/5/10.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import Result
import Moya


/// Network activity change notification type.
public enum MyNetworkActivityChangeType {
    case began, ended
}



public final class LxCustomPlugin: PluginType {
    
    
    public typealias MyNetworkActivityClosure = (_ change: MyNetworkActivityChangeType, _ target: TargetType) -> Void
    let myNetworkActivityClosure: MyNetworkActivityClosure
    
    public init(newNetworkActivityClosure: @escaping MyNetworkActivityClosure) {
        self.myNetworkActivityClosure = newNetworkActivityClosure
    }
    
    // MARK: Plugin
    
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        myNetworkActivityClosure(.began,target)
    }
      
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        myNetworkActivityClosure(.ended,target)
    }
    
   
        
   
}

