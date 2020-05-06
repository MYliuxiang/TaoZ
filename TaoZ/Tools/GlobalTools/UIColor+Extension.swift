//
//  UIColor+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

/// rgba元组， r，g，b为0 ~ 255的值
public typealias LJRGBAValue = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

extension UIColor {
    
    /// r，g，b，a的值
    open var ex_rgbaValue: LJRGBAValue {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red * 255, green * 255, blue * 255, alpha)
    }
    
    /// 是否是深色
    open var ex_isDark: Bool {
        if(ex_rgbaValue.red * 0.299 + ex_rgbaValue.green * 0.587 + ex_rgbaValue.blue * 0.114 >= 192) {
            // 浅色
            return false
        } else {
            // 深色
            return true
        }
    }
    
    /// 16进制字符串
    open var ex_hexString: String {
        let rgb :Int = Int(ex_rgbaValue.red) << 16 | Int(ex_rgbaValue.green) << 8 | Int(ex_rgbaValue.blue)
        return String(format: "%06X", rgb)
    }
    
    /// 反色
    open var ex_invertColor: UIColor {
        return UIColor(r: 255 - ex_rgbaValue.red, g: 255 - ex_rgbaValue.green, b: 255 - ex_rgbaValue.blue)
    }
    
    /// 根据r、g、b、a生成颜色
    ///
    /// - Parameters:
    ///   - r: 红
    ///   - g: 绿
    ///   - b: 蓝
    ///   - a: 透明度
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 根据16进制数hexValue生成颜色
    ///
    /// - Parameter hexValue: 16进制数
    public convenience init(_ hexValue: UInt64, alpha: CGFloat = 1.0) {
        let r = CGFloat((hexValue & 0xFF0000) >> 16)
        let g = CGFloat((hexValue & 0xFF00) >> 8)
        let b = CGFloat(hexValue & 0xFF)
        self.init(r: r, g: g, b: b, a: alpha)
    }
    
    /// 根据16进制字符串hexString生成颜色
    ///
    /// - Parameter hexString: 16进制字符串
    public convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        self.init(hexValue, alpha: alpha)
    }
    
    /// 随机颜色
    ///
    /// - Returns: 颜色实例
    open class func ex_randomColor() -> UIColor {
        return ex_randomColor(fromValue: 0, toValue: 255)
    }
    
    /// 指定范围的随机颜色
    ///
    /// - Parameters:
    ///   - fromValue: 起始值
    ///   - toValue: 结束值
    /// - Returns: 颜色实例
    open class func ex_randomColor(fromValue: CGFloat, toValue: CGFloat) -> UIColor {
        let from = max(min(fromValue, toValue), 0)
        let to = min(max(fromValue, toValue), 255)
        let delta = to - from
        if delta == 0 {
            return UIColor(r: fromValue, g: fromValue, b: fromValue)
        }
        let r: CGFloat = CGFloat(arc4random() % UInt32(delta)) + from
        let g: CGFloat = CGFloat(arc4random() % UInt32(delta)) + from
        let b: CGFloat = CGFloat(arc4random() % UInt32(delta)) + from
        return UIColor(r: r, g: g, b: b)
    }
    
    /// 通过两个颜色的中间比例值，获取中间颜色
    ///
    /// - Parameters:
    ///   - fromColor: 起始颜色
    ///   - toColor: 结束颜色
    ///   - percent: 中间值
    /// - Returns: 新的颜色实例
    open class func ex_averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        let fromRgbaValue = fromColor.ex_rgbaValue
        let toRgbaValue = toColor.ex_rgbaValue
        let red = fromRgbaValue.red + (toRgbaValue.red - fromRgbaValue.red) * percent
        let green = fromRgbaValue.green + (toRgbaValue.green - fromRgbaValue.green) * percent
        let blue = fromRgbaValue.blue + (toRgbaValue.blue - fromRgbaValue.blue) * percent
        let alpha = fromRgbaValue.alpha + (toRgbaValue.alpha - fromRgbaValue.alpha) * percent
        return UIColor(r: red, g: green, b: blue, a: alpha)
    }
    
    /// 16进制颜色，格式 0xC7C7CC
    static func colorWithHex(hexColor: Int, alpha: CGFloat? = 1) -> UIColor
    {
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
        
    }
    
    class func colorWithHexStr(_ hex: String) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            //cString = cString.substring(from: index)
            cString = String(cString[index...]) // Swift 4
        }
        
        if (cString.count != 6) {
            
            return UIColor.red
        }
    
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        //let rString = cString.substring(to: rIndex)
        let rString = String(cString[..<rIndex])
        
        //let otherString = cString.substring(from: rIndex)
        let otherString = String(cString[rIndex...])
        
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        
        //let gString = otherString.substring(to: gIndex)
        let gString =  String(otherString[..<gIndex])
        
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        //let bString = cString.substring(from: bIndex)
        let bString = String(cString[bIndex...])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: (1))
    }
    
    
    /// 16进制转化Color
    ///
    /// - Parameters:
    ///   - hex: 16进制
    ///   - alpha: 透明度
    /// - Returns: Color
    class func colorWithHexStr(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}

