//
//  Bundle+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit


extension Bundle {
    
    //应用名
    class func appDisplayName () -> String
    {
        var name = ""
        
        if let infoDic = Bundle.main.infoDictionary
        {
            if let displayName = infoDic["CFBundleDisplayName"] as? String
            {
                name = displayName
            }
        }
        return name
    }
    
    //version
    class func appShortVersion() ->String
    {
        var appShortVersionStr:String = ""
        
        if let infoDic = Bundle.main.infoDictionary
        {
            if let shortVersionString = infoDic["CFBundleShortVersionString"] as? String
            {
                appShortVersionStr = shortVersionString
            }
        }
        return appShortVersionStr
    }
    
    //build
    class func appBundleVersion() -> String
    {
        var appBundleVersion: String = ""
        if let infoDic = Bundle.main.infoDictionary
        {
            if let bundleVersion = infoDic["CFBundleVersion"] as? String
            {
                appBundleVersion = bundleVersion
            }
        }
        return appBundleVersion
    }
    
}

