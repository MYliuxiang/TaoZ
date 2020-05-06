//
//  UIView+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

// MARK: -  UIView通用封装
extension UIView {
    
    /// 获取所属的viewController
    open var ex_viewController: UIViewController? {
        var nextView: UIView? = self
        while nextView?.superview != nil {
            nextView = nextView?.superview
            if let nextResponder = nextView?.next, let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// 移除指定类型的子视图
    ///
    /// - Parameter subviewClass: 需要移除的子视图类型，默认为UIView
    open func ex_removeSubviews(_ subviewClass: AnyClass = UIView.self) {
        for subview in self.subviews {
            if subview.isKind(of: subviewClass) {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    /// 获取截图
    ///
    /// - Parameters:
    ///   - rect: 截图范围，默认为CGRect.zero
    ///   - scale: 图片缩放因子，默认为屏幕缩放因子
    /// - Returns: 截图
    open func ex_snapshotImage(_ rect: CGRect = .zero, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        // 获取整个区域图片
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        drawHierarchy(in: frame, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        // 如果不裁剪图片，直接返回整张图片
        if rect.equalTo(.zero) || rect.equalTo(bounds) {
            return image
        }
        // 按照给定的矩形区域进行剪裁
        guard let sourceImageRef = image.cgImage else { return nil }
        let newRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        guard let newImageRef = sourceImageRef.cropping(to: newRect) else { return nil }
        // 将CGImageRef转换成UIImage
        let newImage = UIImage(cgImage: newImageRef, scale: scale, orientation: .up)
        return newImage
    }
    
    
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // 将某个view 转换成图像
    func getImageFromView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,false,UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
}

