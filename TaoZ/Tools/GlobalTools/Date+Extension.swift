//
//  Date+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

// MARK: -  日期简单处理
extension Date {
    
    /// 时间戳
    public var ex_timestamp: TimeInterval {
        return timeIntervalSince1970
    }
    
    /// 通过时间戳创建实例
    ///
    /// - Parameter timestamp: 时间戳
    public init(timestamp: TimeInterval) {
        self.init(timeIntervalSince1970: timestamp)
    }
    
    /// 年
    public var ex_year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    
    /// 月
    public var ex_month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    
    /// 日
    public var ex_day: Int {
        return NSCalendar.current.component(.day, from: self)
    }
    
    /// 时
    public var ex_hour: Int {
        return NSCalendar.current.component(.hour, from: self)
    }
    
    /// 分
    public var ex_minute: Int {
        return NSCalendar.current.component(.minute, from: self)
    }
    
    /// 秒
    public var ex_second: Int {
        return NSCalendar.current.component(.second, from: self)
    }
    
    /// 星期几，数字(1~7)
    public var ex_weekday: Int {
        return NSCalendar.current.component(.weekday, from: self)
    }
    
    /// 星期几，中文名称（星期一、星期二...星期日）
    public var ex_weekdayName: String {
        guard let weekdayName = Weekday(rawValue: ex_weekday)?.description else {
            fatalError("Error: weekday:\(ex_weekday)")
        }
        return weekdayName
    }
    
    /// 是否是今天
    public var ex_isToday: Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    /// 是否是昨天
    public var ex_isYesterday: Bool {
        return NSCalendar.current.isDateInYesterday(self)
    }
    
    /// 获取当前 秒级 时间戳 - 10位
      public  var timeStamp : String {
         let timeInterval: TimeInterval = self.timeIntervalSince1970
         let timeStamp = Int(timeInterval)
         return "\(timeStamp)"
      }

         /// 获取当前 毫秒级 时间戳 - 13位
       public  var milliStamp : String {
         let timeInterval: TimeInterval = self.timeIntervalSince1970
         let millisecond = CLongLong(round(timeInterval*1000))
         return "\(millisecond)"
     }
    
    
}

// MARK: -  格式化
extension Date {
    
    /// 时间格式化成字符串
    ///
    /// - Parameter dateFormat: 格式
    /// - Returns: 时间字符串
    public func ex_string(with dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    /// 通过字符串创建实例
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - dateFormat: 格式
    public init?(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
    
    /// 类似微信聊天消息的时间格式化，静态方法
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - showHour: 是否显示时分
    /// - Returns: 格式化后的字符串
    public static func ex_stringWithFormat(timestamp: TimeInterval, showHour: Bool = true) -> String {
        let date = Date(timestamp: timestamp)
        return date.ex_stringWithFormat(showHour: showHour)
    }
    
    /// 类似微信聊天消息的时间格式化，实例
    ///
    /// - Parameter showHour: 是否显示时分
    /// - Returns: 格式化后的字符串
    public func ex_stringWithFormat(showHour: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        if ex_isToday {
            /// 如果是今天
            dateFormatter.dateFormat = "HH:mm"
        } else if ex_isYesterday {
            /// 如果是昨天
            dateFormatter.dateFormat = showHour ? "昨天 HH:mm" : "昨天"
        } else if ex_numberOfdays(to: Date()) < 7 {
            /// 如果在一周内
            dateFormatter.dateFormat = showHour ? "\(ex_weekdayName) HH:mm" : "\(ex_weekdayName)"
        } else {
            /// 如果是今年
            if ex_year == Date().ex_year {
                dateFormatter.dateFormat = showHour ? "MM月dd日 HH:mm" : "MM月dd日"
            } else {
                dateFormatter.dateFormat = showHour ? "yyyy年MM月dd日 HH:mm" : "yyyy年MM月dd日"
            }
        }
        return dateFormatter.string(from: self)
    }
    
    
    /// 获取两个日期之间相隔的天数，self为起始日期，date为截止日期
    ///
    /// - Parameter date: 截止日期
    /// - Returns: 相隔天数
    public func ex_numberOfdays(to date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: date)
        return components.day ?? 0
    }
    
    //MARK: -根据后台时间戳返回几分钟前，几小时前，几天前
   public func updateTimeToCurrennTime(timeStamp: Double) -> String {
          //获取当前的时间戳
          let currentTime = Date().timeIntervalSince1970
//          print(currentTime,   timeStamp, "sdsss")
          //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
          let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
          //时间差
          let reduceTime : TimeInterval = currentTime - timeSta
          //时间差小于60秒
          if reduceTime < 60 {
              return "刚刚"
          }
          //时间差大于一分钟小于60分钟内
          let mins = Int(reduceTime / 60)
          if mins < 60 {
              return "\(mins)分钟前"
          }
          let hours = Int(reduceTime / 3600)
          if hours < 24 {
              return "\(hours)小时前"
          }
          let days = Int(reduceTime / 3600 / 24)
          if days < 30 {
              return "\(days)天前"
          }
          //不满足上述条件---或者是未来日期-----直接返回日期
          let date = NSDate(timeIntervalSince1970: timeSta)
          let dfmatter = DateFormatter()
          //yyyy-MM-dd HH:mm:ss
          dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
          return dfmatter.string(from: date as Date)
      }
    
}

// MARK: -  Weekday简单封装
public enum Weekday: Int {
    
    case sunday    = 1
    case monday    = 2
    case tuesday   = 3
    case wednesday = 4
    case thursday  = 5
    case friday    = 6
    case saturday  = 7
    
    init?(weekdayString: String) {
        switch weekdayString {
        case Weekday.sunday.description:     self = .sunday
        case Weekday.monday.description:     self = .monday
        case Weekday.tuesday.description:    self = .tuesday
        case Weekday.wednesday.description:  self = .wednesday
        case Weekday.thursday.description:   self = .thursday
        case Weekday.friday.description:     self = .friday
        case Weekday.saturday.description:   self = .saturday
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .sunday:     return "星期日"
        case .monday:     return "星期一"
        case .tuesday:    return "星期二"
        case .wednesday:  return "星期三"
        case .thursday:   return "星期四"
        case .friday:     return "星期五"
        case .saturday:   return "星期六"
        }
    }
    
}


