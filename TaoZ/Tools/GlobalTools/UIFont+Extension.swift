//
//  UIFont+Extension.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import Foundation

extension UIFont{
    
    open class func customName(_ name:String, size:CGFloat)->UIFont{
        
        return UIFont.init(name: "Gilroy-" + name, size: size) ?? UIFont.systemFont(ofSize: 16)
    }
}
