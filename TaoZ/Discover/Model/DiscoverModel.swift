//
//  DiscoverModel.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class DiscoverModel: BaseModel {
    var id:String? //动态ID
    var dynamic_id:String? //动态ID
    var user_id:String? //用户ID
    var content:String? //动态内容
    var createtime:String? //发布时间
    var lbs:String? //地理位置
    var file:String? //动态ID
    var imgArray: [String]?
       {
           guard let img = file, img.count > 0 ,img != "" else
             {
                 return [String]()
             }
           
           return YMKJSONString.getArrayFromJSONString(jsonString: img) as? [String]
       }
    
    var views:String? //观看量
    var feedback_count:String? //评论数目
    var click_count:String? //点赞数目
    var collect_count:String? //收藏数目
    var is_click:Int? //0未点赞1已点赞
    var is_collect:Int? ////0未收藏1已收藏
    var userinfo:Userinfo? ////0未收藏1已收藏
    var type:Int? ////动态类型:1图片2视频
    
}

class Userinfo: BaseModel {
    var id:String? //用户ID
    var nickname:String? //用户昵称
    var avatar:String? //头像
    var is_model:Int? //0不是模特1是模特(如果是模特需要显示真人)
    var expiry_date:String? //会员到期时间(如果不为空，显示VIP)
    var is_online:Int? //0在线1离线
    var gender:Int? //0未知1女2男
    var url:String? //
    
    
    
}
