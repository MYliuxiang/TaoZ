//
//  ShareHelper.swift
//  YJKApp
//
//  Created by YJK on 2020/3/12.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

class ShareModel: BaseModel {
    ///标题
    var title :String?
    ///描述
    var detail :String?
    ///图片
    var imageUrl :String?
    ///分享链接
    var shareUrl :String?
    ///图片分享时的图片
    var shareImage: UIImage = UIImage()
    ///默认图片
    var defaultImage = UIImage(named: "share_default")
}

class ShareHelper: NSObject {
    
    /// 分享内容类别枚举
    enum EnumShareContentType
    {
        ///文本
        case text
        
        ///图片
        case image
        
        ///图文
        case imageText
        
        ///web链接
        case webLink
        
        ///视频链接
        case videoLink
        
        ///音乐链接
        case musicLink
        
        ///其他
        case other
    }
    
    /// 分享类型
    enum EnumSharePlatform: Int
    {
        ///微信，朋友圈，qq，空间，新浪，拉黑，举报
        case `default`
        /// 微信，朋友圈，qq，空间，新浪，删除
        case delete
        /// 微信，朋友圈，qq，空间，新浪
        case code
        
    }
    
    
    public typealias CompletionClickedHandler = ((Bool,ShareItem) -> Void)
    
    static var defaultIAPHelper :ShareHelper{
        struct Single{
            static  let defaultIAPHelper = ShareHelper()
        }
        return Single.defaultIAPHelper
    }
    
    
    /// 分享功能
    /// - Parameters:
    ///   - sharePlatform: 分享平台 默认 微信，朋友圈，qq，空间，新浪
    ///   - shareContentType: 分享内容类别枚举 默认web链接
    ///   - shareModel: 分享model
    ///   - completion:  回调
    class func showShare(sharePlatform: EnumSharePlatform = .default,shareContentType:EnumShareContentType = .webLink,shareModel:ShareModel, completion: CompletionClickedHandler?) {
        
        
        let shareItem1 = ShareItem(title: "微信好友", icon:#imageLiteral(resourceName: "share_icon_wechat") ,itemType: .wechatSession)
        let shareItem2 = ShareItem(title: "朋友圈", icon: #imageLiteral(resourceName: "share_icon_friendcircle") ,itemType: .wechatTimeLine)
        let shareItem3 = ShareItem(title: "QQ好友", icon: #imageLiteral(resourceName: "share_icon_qq") ,itemType: .qq)
        let shareItem4 = ShareItem(title: "QQ空间", icon: #imageLiteral(resourceName: "share_qzone") ,itemType: .qzone)
        let shareItem5 = ShareItem(title: "新浪微博", icon: #imageLiteral(resourceName: "share_icon_sina") ,itemType: .sina)
        let shareItem6 = ShareItem(title: "删除", icon: #imageLiteral(resourceName: "share_icon_delete") ,itemType: .delete)
        //        let shareItem7 = ShareItem(title: "拉黑", icon: #imageLiteral(resourceName: "share_icon_black") ,itemType: .balck)
        let shareItem8 = ShareItem(title: "举报", icon: #imageLiteral(resourceName: "share_icon_report") ,itemType: .report)
        let shareItem9 = ShareItem(title: "保存图片", icon: #imageLiteral(resourceName: "share_icon_haibao") ,itemType: .save)
        
        
        
        var shareList: [ShareItem] = []
        if UMSocialManager.default().isInstall(UMSocialPlatformType.wechatSession){
            shareList.append(contentsOf: [shareItem1, shareItem2])
        }
        
        if UMSocialManager.default().isInstall(UMSocialPlatformType.QQ){
            shareList.append(contentsOf: [shareItem3, shareItem4])
        }
        
        if UMSocialManager.default().isInstall(UMSocialPlatformType.sina){
            shareList.append(contentsOf: [shareItem5])
        }
        
        var shareList1: [ShareItem] = []
        
        if sharePlatform == .default {
            
            shareList1.append(contentsOf: [shareItem8])
        }
        
        if sharePlatform == .delete {
            
            shareList1.append(contentsOf: [shareItem6])
        }
        
        
        if sharePlatform == .code {
            
            shareList1.append(contentsOf: [shareItem9])
        }
        
        let clickedHandler = { (shareView: ShareView, indexPath: IndexPath) in
            if indexPath.section == 1 {
                let shareItem = shareList[indexPath.row]
                toShare(shareItem: shareItem, shareModel: shareModel,shareContentType:shareContentType,completion:completion)
            } else if indexPath.section == 2 {
                let shareItem = shareList1[indexPath.row]
                if shareItem.itemType == .save {
                    
                    //保存图片
                    TZImageManager.default()?.savePhoto(with: shareModel.shareImage, completion: { (asset, error) in
                          if ((error) != nil) {
                               print("图片保存相册失败 \(error ?? NSError())");
                           } else {
                            SVProgressHUD.showSuccess(withStatus: "保存成功")
                               print("图片保存相册成功");
                           }
                    })
                    
                    return
                }
                
                if completion != nil {
                    completion!(true,shareItem)
                }
            }
            print(indexPath.section, indexPath.row)
        }
        
        if shareList1.count == 0 {
            let shareView = ShareView(shareItems: [shareList], clickedHandler: clickedHandler)
            shareView.show()
        } else {
            let shareView = ShareView(shareItems: [shareList,shareList1], clickedHandler: clickedHandler)
            shareView.show()
        }
        
        
    }
    
    
    /// 去分享
    /// - Parameters:
    ///   - shareItem: 分享按钮模型
    ///   - shareModel: 分享model
    ///   - shareContentType: 享内容类别枚举 默认web链接
    ///   - completion: 回调
    class func toShare(shareItem:ShareItem,shareModel:ShareModel,shareContentType:EnumShareContentType = .webLink ,completion: CompletionClickedHandler?)  {
        
        
        var platformType :UMSocialPlatformType
        switch shareItem.itemType{
        case .wechatSession:
            platformType = .wechatSession
        case .wechatTimeLine:
            platformType = .wechatTimeLine
        case .qq:
            platformType = .QQ
        case .qzone:
            platformType = .qzone
        case .sina:
            platformType = .sina
        case .wechatFavorite:
            platformType = .wechatFavorite
        default:
            platformType = .sina
            break
        }
        
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        
        // 分享图片
        if shareContentType == .image
        {
            let shareObject = UMShareImageObject()
            shareObject.thumbImage = shareModel.shareImage
            shareObject.shareImage = shareModel.shareImage
            messageObject.shareObject = shareObject
        }
        
        //分享web链接
        if shareContentType == .webLink {
            
            //分享内容
            let shareObject = UMShareWebpageObject.shareObject(withTitle: shareModel.title, descr: shareModel.detail, thumImage: shareModel.imageUrl == "" ? shareModel.defaultImage :  shareModel.imageUrl)
            shareObject?.webpageUrl = shareModel.shareUrl
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject
            
            //微博专用 图文
            if platformType == .sina
            {
                messageObject.text = "\(shareModel.title ?? "")\n\(shareModel.detail ?? "")\(shareModel.shareUrl ?? "")"
                let imageObject = UMShareImageObject()
                imageObject.shareImage = (shareModel.imageUrl == "" ? shareModel.defaultImage : shareModel.imageUrl)
                messageObject.shareObject = imageObject
                
            }
            
        }
        
        
        
        UMSocialManager.default()?.share(to: platformType, messageObject: messageObject, currentViewController: UIViewController.currentViewController(), completion: { (result, error) in
            
            if completion != nil {
                completion!(error == nil ? true : false,shareItem)
            }
            
        })
        
        
    }
    
}
