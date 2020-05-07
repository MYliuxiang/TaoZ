//
//  ShareItem.swift
//  YJKApp
//
//  Created by YJK on 2020/3/11.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

public typealias SelectionHandler = ((ShareItem) -> Void)

public class ShareItem: NSObject {
    
    //Item类型
   public enum EnumItemType: Int
    {
        case wechatSession //微信好友
        case wechatTimeLine //微信朋友圈
        case wechatFavorite //微信收藏
        case qq //QQ
        case qzone //qzone
        case sina //新浪
        case safari //Safari
        case copy     //拷贝
        case facebook //facebook
        case delete //删除
        case balck //拉黑
        case save //保存
        case report //举报

    }
    /// 标题
    public var title: String
    /// 图片名称
    public var icon: UIImage
    /// 图片名称
    public var itemType: EnumItemType
    /// 点击事件
    public var selectionHandler: SelectionHandler?
    
    public init(title: String, icon: UIImage, itemType: EnumItemType, selectionHandler: SelectionHandler? = nil) {
        self.title = title
        self.icon = icon
        self.itemType = itemType
        self.selectionHandler = selectionHandler
    }
}
