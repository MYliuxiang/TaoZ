//
//  UIImage+Extension.swift
//  YMKForB
//
//  Created by YMK on 2019/7/27.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 通过颜色生成图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片尺寸
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext(),
            let imageRef = image.cgImage else { return nil }
        self.init(cgImage: imageRef)
    }
    
    /// 获取图片某一点的颜色
    ///
    /// - Parameter point: 目标点，x、y为0-1之间的数，表示在图片中的点的比例位置
    /// - Returns: 得到的颜色
    open func ex_color(at point: CGPoint) -> UIColor? {
        guard let imageRef = cgImage else { return nil }
        let realPointX = Int(CGFloat(imageRef.width) * point.x) + 1
        let realPointY = Int(CGFloat(imageRef.height) * point.y) + 1
        let rect = CGRect(x: 0, y: 0, width: CGFloat(imageRef.width), height: CGFloat(imageRef.height))
        let realPoint = CGPoint(x: realPointX, y: realPointY)
        guard rect.contains(realPoint) else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        let pixelData = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
        guard let context = CGContext(data: pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo) else { return nil }
        context.setBlendMode(.copy)
        context.translateBy(x:  -CGFloat(realPointX), y: CGFloat(realPointY - imageRef.height))
        context.draw(imageRef, in: rect)
        let red = CGFloat(pixelData[0]) / 255
        let green = CGFloat(pixelData[1]) / 255
        let blue = CGFloat(pixelData[2]) / 255
        let alpha = CGFloat(pixelData[3]) / 255
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    

}

extension UIImage {
    
    /// 按比例缩放图片
    ///
    /// - Parameter scale: 缩放比例
    /// - Returns: 缩放后的图片
    open func ex_resize(with scale: CGFloat) -> UIImage {
        let newSize = size.applying(CGAffineTransform(scaleX: scale, y: scale))
        return ex_resize(to: newSize)
    }
    
    /// 图片缩放到指定尺寸
    ///
    /// - Parameter newSize: 新尺寸
    /// - Returns: 缩放后的图片
    open func ex_resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return newImage
    }
    
    /// 剪切图片
    ///
    /// - Parameter rect: 剪切的范围
    /// - Returns: 剪切后的图片
    open func ex_cutImage(to rect: CGRect) -> UIImage {
        guard let cgImage = cgImage,
            let imageRef = cgImage.cropping(to: rect) else { return self }
        let refRect = CGRect(x: 0, y: 0, width: imageRef.width, height: imageRef.height)
        UIGraphicsBeginImageContext(refRect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(imageRef, in: refRect)
        let image = UIImage(cgImage: imageRef)
        UIGraphicsEndImageContext()
        return image
    }
    
    //设置水印
    public class func getWaterMark(_ originalImage: UIImage?, title: String,markFont: UIFont,markColor: UIColor) -> UIImage? {
        let HORIZONTAL_SPACE: CGFloat = 30
        let VERTICAL_SPACE: CGFloat = 50
        var font: UIFont? = markFont
        if font == nil {
            font = UIFont.systemFont(ofSize: 23)
        }
        var color: UIColor? = markColor
        if color == nil {
            color = UIColor.blue
        }
        //原始image的宽高
        guard let viewWidth = originalImage?.size.width, let viewHeight = originalImage?.size.height else { return nil }
        //为了防止图片失真，绘制区域宽高和原始图片宽高一样
        UIGraphicsBeginImageContext(CGSize(width: viewWidth, height: viewHeight))
        //先将原始image绘制上
        originalImage?.draw(in: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
        let sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
        
        let attrStr = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
        //绘制文字的宽高
        let strWidth = attrStr.size().width
        let strHeight = attrStr.size().height
        
        //开始旋转上下文矩阵，绘制水印文字
        let context = UIGraphicsGetCurrentContext()
        
        //将绘制原点（0，0）调整到源image的中心
        context?.concatenate(CGAffineTransform(translationX: viewWidth / 2, y: viewHeight / 2))
        //以绘制原点为中心旋转
        context?.concatenate(CGAffineTransform(rotationAngle: CGFloat(M_PI_2 / 3)))
        //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
        context?.concatenate(CGAffineTransform(translationX: -viewWidth / 2, y: -viewHeight / 2))
        
        //计算需要绘制的列数和行数
        let horCount: Int = Int(sqrtLength / CGFloat(strWidth + HORIZONTAL_SPACE)) + 1
        let verCount: Int = Int(sqrtLength / CGFloat(strHeight + VERTICAL_SPACE)) + 1
        //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        let orignX: CGFloat = -(sqrtLength - viewWidth) / 2
        let orignY: CGFloat = -(sqrtLength - viewHeight) / 2
        //在每列绘制时X坐标叠加
        var tempOrignX: CGFloat = orignX
        //在每行绘制时Y坐标叠加
        var tempOrignY: CGFloat = orignY
        for i in 0..<horCount * verCount {
            title.draw(in: CGRect(x: tempOrignX, y: tempOrignY, width: strWidth, height: strHeight), withAttributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
            if i % horCount == 0 && i != 0 {
                tempOrignX = orignX
                tempOrignY += strHeight + VERTICAL_SPACE
            } else {
                tempOrignX += strWidth + HORIZONTAL_SPACE
            }
        }
        //根据上下文制作成图片
        let finalImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImg
    }
    
}


