//
//  BlankpageHelper.swift
//  YJKApp
//
//  Created by YJK on 2020/3/18.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

//默认
let def_image = "def_noImages"
let def_userimage = "def_userImg"
let def_noDataimage = "def_noData"
let def_noNetimage = "def_noNet"
let def_noOrder = "noOrder"
let def_noGoods = "def_noShop"
let def_address = "def_address"
let def_noCart = "def_noCart"


class BlankpageHelper: NSObject,EmptyDataSetable {

    /// 类型
    enum EmptyConfigType
    {
        ///没有内容
        case noData
        
        ///网络没有连接
        case noNet
        
        ///页面加载失败
        case loadFaile

        ///自定义
        case custom
    }
    
    static var defaultIAPHelper :BlankpageHelper{
          struct Single{
              static  let defaultIAPHelper = BlankpageHelper()
          }
          return Single.defaultIAPHelper
     }
    
    
    /// 空白图设置
    /// - Parameters:
    ///   - emptyConfigType: 显示类型
    ///   - verticalOffset: 纵向偏移(-50)  CGFloat
    ///   - tipStr: 提示语(暂无数据)  String
    ///   - tipFont: 提示语的font(system13)  UIFont
    ///   - tipColor: 提示语颜色  UIColor
    ///   - tipImage: 提示图 UIImage
    ///   - spaceHeight: 各元素之间的间距(5)
    class func emptyaSetConfig(emptyConfigType:EmptyConfigType = .noData,verticalOffset:CGFloat = -50,tipStr:String = "",tipFont:UIFont = UIFont.systemFont(ofSize: 14), tipColor:UIColor = UIColor.colorWithHex(hexColor: 0x3471D5, alpha: 0.65),tipImage:UIImage = UIImage(named: def_noDataimage)!,spaceHeight:CGFloat = 5) -> EmptyDataSetConfigure {
    
        let normal = EmptyDataSetConfigure(verticalOffset:verticalOffset,tipStr:tipStr,tipFont: tipFont, tipColor: tipColor, tipImage: tipImage, spaceHeight: spaceHeight)
        var config = normal
        switch emptyConfigType {
        case .noData:
            config.tipStr = "暂无数据"
            config.tipImage = UIImage(named: def_noDataimage)
        case .noNet:
            config.tipStr = "无网络"
            config.tipImage = UIImage(named: def_noNetimage)
        case .loadFaile:
            config.tipStr = "呃，页面加载失败"
            config.tipImage = UIImage(named: def_noNetimage)
            config.buttonTitle = NSAttributedString(string: "重新加载")
        default:
            break
        }
        return config
    }
    
   class func addDateEmpty( _ scrollView: UIScrollView,config: EmptyDataSetConfigure?) {
        BlankpageHelper.defaultIAPHelper.lxf.updateEmptyDataSet(scrollView, config:config)
    }
    
    enum EmptyTyp {
        /// 无网络
        case noNet
        /// 加载失败
        case faile
        /// 没有数据  (默认)
        case noData
        /// 没有订单数据
        case noOrder
        /// 没有购物车
        case noCart
        
        var tipStr: String {
            switch self {
            case .noNet:
                return "无网络"
            case .faile:
                return "加载失败"
            case .noData:
                return "暂无数据"
            case .noOrder:
                return "暂无订单"
            case .noCart:
                return "购物车竟然是空的"
            }
        }
        
        var btnTitle: String? {
            switch self {
            case .noCart:
                return "去首页逛逛"
            default:
                return nil
            }
        }
        
        var tipImage: String {
            switch self {
            case .noNet:
                return def_noNetimage
            case .faile:
                return def_noDataimage
            case .noData:
                return def_noDataimage
            case .noOrder:
                return def_noOrder
            case .noCart:
                return def_noCart
            }
        }
        
        var verticalOffset: CGFloat {
            switch self {
            default:
                return -50
            }
        }
    }
    class func addEmpty(_ scrollView: UIScrollView, type: EmptyTyp) {
        var config = EmptyDataSetConfigure()
        config.verticalOffset = type.verticalOffset
        config.tipFont = UIFont.systemFont(ofSize: 14)
        config.tipColor = UIColor.colorWithHex(hexColor: 0x9B9B9B)
        
        config.tipStr = type.tipStr
        config.tipImage = UIImage(named: type.tipImage)
        if let btnStr = type.btnTitle {
            
            //            config.buttonImageBlock = { (state) in
            //                return UIImage(named: "noCartbg")
            //            }
            
            config.buttonTitle = NSAttributedString(string: btnStr, attributes:
                [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
                 NSAttributedString.Key.foregroundColor:UIColor.colorWithHex(hexColor: 0x6D9AF7),
                 NSAttributedString.Key.underlineStyle: 1,
                 NSAttributedString.Key.underlineColor: UIColor.colorWithHex(hexColor: 0x6D9AF7)])
        }
        
        BlankpageHelper.defaultIAPHelper.lxf.updateEmptyDataSet(scrollView, config:config)
        
    }
}


/**
 *添加
    BlankpageHelper.addEmpty(tableView, type: BlankpageHelper.EmptyTyp.noGoods)
    btn点击回调
    BlankpageHelper.defaultIAPHelper.lxf.tapEmptyButton(tableView) { (btn) in }
 
 */
