//
//  UIButton+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

public enum  ButtonEdgeInsetsStyle :Int{//认证方式
    case none = 0    //无
    case top = 1     // image在上，label在下
    case left = 2   // image在左，label在右
    case bottom = 3  // image在下，label在上
    case right = 4  // image在右，label在左
   
}

extension UIButton {
    
    /// 设置button的titleLabel和imageView的布局样式，及间距
    ///
    /// - Parameters:
    ///   - style: titleLabel和imageView的布局样式
    ///   - space: titleLabel和imageView的间距
    public func layoutButtonWithEdgeInsetsStyle (style:ButtonEdgeInsetsStyle,space:CGFloat)
    {
        // 1. 得到imageView和titleLabel的宽、高
        let imageWith:CGFloat = self.imageView?.frame.size.width ?? 0.0
        let imageHeight:CGFloat = self.imageView?.frame.size.height ?? 0.0

        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0.0
       
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero;
        var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero;
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-space/2.0, right: 0);
             break
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0);
            break
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0);
            break
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith-space/2.0, bottom: 0, right: imageWith+space/2.0);
            break
       case .none:
            break
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
    
    
    //倒计时发送短信
    public func startTime(enabelTitle:String,enabelTitleColor:UIColor,enabelbgColor:UIColor,unEnabelLeftTittle:String,unEnabelRightTittle:String,unEnabelTitleColor:UIColor,unEnabelbgColor:UIColor,timeout: Int,finshBlock : (()->Void)?){
        // 倒计时开始,禁止点击事件
        isEnabled = false
        
        // 设置倒计时,按钮背景颜色
        backgroundColor = unEnabelbgColor
        setTitleColor(unEnabelTitleColor, for: .normal)
        
        var remainingCount: Int = timeout {
            willSet {
                setTitle("\(unEnabelLeftTittle)\(newValue)\(unEnabelRightTittle)", for: .normal)
                
                if newValue <= 0 {
                    setTitle(enabelTitle, for: .normal)
                    if finshBlock != nil{
                        finshBlock!()
                    }
                }
            }
        }
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = enabelbgColor
                    self.setTitleColor(enabelTitleColor, for: .normal)
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
    
}
