//
//  LLog.swift
//  YJKApp
//
//  Created by YJK on 2020/3/11.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

// MARK: - 封装的日志输出功能（T表示不指定日志信息参数类型）
public func LLog<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line, outputType: EnumMLogOutputType = EnumMLogOutputType.default)
{
    #if DEBUG
    
        /// 获取文件名
        let fileName = (file as NSString).lastPathComponent
    
        /// 创建一个日期格式器
        let dformatter = DateFormatter()
    
        /// 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        /// 使用日期格式器格式化当前日期、时间
        let datestr = dformatter.string(from: Date())
    
    switch outputType
    {
    case .default:
        
        /// 打印日志内容
        print("\n<time: \(datestr) -> fileName: \(fileName) -> line: \(line) -> func: \(function)>: \(message)\n")
        
    case .time:
        
        /// 打印日志内容
        print("\n<time: \(datestr)>: \(message)\n")
        
    case .simple:
        
        /// 打印日志内容
        print(message)
    }
    
    #endif
}

/// 日志输出的类型
public enum EnumMLogOutputType
{
    /// 默认(输出所有信息)
    case `default`
    
    /// 时间(输出时间)
    case time
    
    /// 简单(只输出内容)
    case simple
}
