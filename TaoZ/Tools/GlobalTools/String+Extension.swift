//
//  String+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit
import CommonCrypto

// MARK: -  操作字符串
extension String {
    
    /// 插入字符串
    ///
    /// - Parameters:
    ///   - text: 要插入的字符串
    ///   - index: 要插入的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_insert(_ text: String, at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(contentsOf: text, at: insertIndex)
        return self
    }
    
    /// 插入字符
    ///
    /// - Parameters:
    ///   - text: 要插入的字符
    ///   - index: 要插入的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_insert(_ text: Character, at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(text, at: insertIndex)
        return self
    }
    
    /// 删除字符串
    ///
    /// - Parameter text: 要删除的字符串
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_remove(_ text: String) -> String {
        if let removeIndex = range(of: text) {
            removeSubrange(removeIndex)
        }
        return self
    }
    
    /// 删除字符串
    ///
    /// - Parameters:
    ///   - index: 删除的字符串起始位置
    ///   - length: 删除的字符串长度
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_remove(at index: Int, length: Int) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let start = self.index(startIndex, offsetBy: index)
        let end = self.index(start, offsetBy: length)
        removeSubrange(start ..< end)
        return self
    }
    
    /// 删除字符
    ///
    /// - Parameter index: 要删除的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_remove(at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let removeIndex = self.index(startIndex, offsetBy: index)
        remove(at: removeIndex)
        return self
    }
    
    /// 替换字符串
    ///
    /// - Parameters:
    ///   - index: 替换的字符串起始位置
    ///   - length: 替换的字符串长度
    ///   - text: 要替换成的字符串
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func ex_replaceText(at index: Int, length: Int, with text: String) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let start = self.index(startIndex, offsetBy: index)
        let end = self.index(start, offsetBy: length)
        replaceSubrange(start ..< end, with: text)
        return self
    }
    
    /// 截取字符串
    ///
    /// - Parameters:
    ///   - index: 截取的字符串起始位置
    ///   - length: 截取的字符串长度
    /// - Returns: 截取的字符串
    public func ex_substring(at index: Int, length: Int) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let fromIndex = self.index(startIndex, offsetBy: index)
        let toIndex = self.index(fromIndex, offsetBy: length)
        return String(self[fromIndex ..< toIndex])
    }
    
    /// 截取字符串，从指定位置到末尾
    ///
    /// - Parameter index: 截取的字符串起始位置
    /// - Returns: 截取的字符串
    public func ex_substring(from index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        return ex_substring(at: index, length: count - index)
    }
    
    /// 截取字符串，从开头到指定位置
    ///
    /// - Parameter index: 截取的字符串结束位置
    /// - Returns: 截取的字符串
    public func ex_substring(to index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        return ex_substring(at: 0, length: index)
    }
    
    /// 去除左右的空格和换行符
    ///
    /// - Returns: 结果字符串
    public func ex_trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 汉字 -> 拼音
    ///
    /// - Returns: 结果字符串
    func chineseToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        return pinyin
    }
    
    /// 判断是否含有中文
    ///
    /// - Returns: Bool
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    
    // MARK: 获取第一个字符
    func first() -> String {
        let index = self.index(self.startIndex, offsetBy: 1)
        return self.substring(to: index)
    }
    
    
    //创建随机字符串
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    
    /// - Returns: 手机号中间4位替换成*
    func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
 
}

// MARK: -  编解码
extension String {
    
    /// 编码之后的url
    public var ex_urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 解码之后的url
    public var ex_urlDecoded: String? {
        return removingPercentEncoding
    }
    
    /// base64编码之后的字符串
    public var ex_base64Encoded: String? {
        guard let base64Data = data(using: .utf8) else { return nil }
        return base64Data.base64EncodedString()
    }
    
    /// base64解码之后的字符串
    public var ex_base64Decoded: String? {
        guard let base64Data = Data(base64Encoded: self) else { return nil }
        return String(data: base64Data, encoding: .utf8)
    }
    
     //md5加密
    public var md5String:String? {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)

        return String(format: hash as String)
    }
}

// MARK: -  验证
extension String {
    
    /// 是否是数字
    public var ex_isNumber: Bool {
        let regex = "^[0-9]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是字母
    public var ex_isLetter: Bool {
        let regex = "^[A-Za-z]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是手机号
    public var ex_isPhoneNumber: Bool {
        let regex = "^1+[3456789]+\\d{9}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是身份证号
    public var ex_isIDNumber: Bool {
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是6位数字
    public var ex_isSixNumber: Bool {
        let regex = "^\\d{6}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是邮箱
    public var ex_isEmail: Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是密码，输入同时包含数字和字母 6-20位
    public var ex_isPassword: Bool {
//        let regex = "^[@A-Za-z0-9!#\\$%\\^&*\\.~_]{6,20}$"
        let regex  = "(^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20})"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
}

// MARK: -  尺寸计算
extension String {
    
    /// 计算字符串尺寸
    ///
    /// - Parameters:
    ///   - size: 限定的size
    ///   - font: 字体
    /// - Returns: 计算出的尺寸
    public func ex_size(with size: CGSize, font: UIFont) -> CGSize {
        if isEmpty {
            return .zero
        }
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
    
    /// 计算字符串的高度
    ///
    /// - Parameters:
    ///   - width: 限定的宽度
    ///   - font: 字体
    /// - Returns: 计算出的高度
    public func ex_height(with width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return ex_size(with: size, font: font).height
    }
    
    /// 计算字符串的宽度
    ///
    /// - Parameter font: 字体
    /// - Returns: 计算出的宽度
    public func ex_width(with font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        return ex_size(with: size, font: font).width
    }
    
}

extension String
{
    // **************************   计算文字高度或者宽度与weight参数无关  ****************************
    /// 高度固定时，获取文本的宽度
    func getWidthForComment(fontSize: CGFloat, height: CGFloat) -> CGFloat
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 高度固定时，获取文本的宽度,有行间距计算
    func getWidthForComment(fontSize: CGFloat, height: CGFloat,paraStyle:NSMutableParagraphStyle) -> CGFloat
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paraStyle], context: nil)
        return ceil(rect.width)
    }
    
    /// 宽度固定时，获取文本的高度
    func getHeightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /// 宽度固定时，获取文本的高度,有行间距计算
    func getHeightForComment(fontSize: CGFloat, width: CGFloat,paraStyle:NSMutableParagraphStyle) -> CGFloat
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paraStyle], context: nil)
        return ceil(rect.height)
    }
    
    /// 宽度固定时，获取 文本的高度(如超过设定的最大高度，则返回设定的最大高度)
    func getHeightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height) > maxHeight ? maxHeight : ceil(rect.height)
    }
    
    /// 设置富文本字体行间距，颜色
    func setAttributedString(textColor: UIColor, lineSpacing : CGFloat = 5,textFont:UIFont = UIFont.systemFont(ofSize: 14),lineBreakMode:NSLineBreakMode = .byWordWrapping) -> NSAttributedString
    {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing //行间距是多少倍
        paraph.lineBreakMode = lineBreakMode
        let attributedString = NSMutableAttributedString(string: self, attributes:[NSAttributedString.Key.foregroundColor:textColor,NSAttributedString.Key.paragraphStyle: paraph,NSAttributedString.Key.font:textFont])
       return attributedString
    }

    
    //************************** 发布时间 *********************
    /// 1分钟内发布的：刚刚
    /// 1小时内发布的：X分钟前
    /// 超过1小时，仍在当天：xx：xx
    /// 跨天，但少于24小时：昨天 xx：xx
    /// 跨天，超过24小时：xxxx/xx/xx
    func yuwandarenTimeRegulation() -> String
    {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = formatter.date(from: self)
//        let dateT = Double(self)
        let stamp = Double(self) ?? 0

        let date = Date(timeIntervalSince1970: stamp)
//        let stamp = date.timeIntervalSince1970
        
        let currentStamp = Date().timeIntervalSince1970
        
        let gap = Int(currentStamp - stamp)
        
        if gap < 60
        {
            return "刚刚"
        }
        else if gap < 3600
        {
            let min = gap / 60
            
            return "\(min)分钟前"
        }
        else if gap < 86400
        {
            
            //当天
            if Calendar.current.isDate(date, inSameDayAs: Date()) {
                
                formatter.dateFormat = "HH:mm"
                let dateString = formatter.string(from: date)
                return "今天 \(dateString)"
                
            } else {
                
                formatter.dateFormat = "HH:mm"
                let dateString = formatter.string(from: date)
                return "昨天 \(dateString)"
            }
        }
        else
        {
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            return "\(dateString)"
        }
    }
    
    func urlScheme(scheme:String) -> URL? {
        if let url = URL.init(string: self) {
            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
            components?.scheme = scheme
            return components?.url
        }
        return nil
    }
    
    func md5() -> String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
    static func format(decimal:Float, _ maximumDigits:Int = 1, _ minimumDigits:Int = 1) ->String? {
        let number = NSNumber(value: decimal)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDigits //设置小数点后最多2位
        numberFormatter.minimumFractionDigits = minimumDigits //设置小数点后最少2位（不足补0）
        return numberFormatter.string(from: number)
    }
    
    static func formatCount(count:NSInteger) -> String {
        if count < 10000  {
            return String.init(count)
        } else {
            return (String.format(decimal: Float(count)/Float(10000)) ?? "0") + "w"
        }
    }

}


