//
//  UserInfoModel.swift
//  YMKForB
//
//  Created by YMK on 2019/7/29.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

class UserInfoModel: BaseModel {
    
    var id: String? //用户id
    var tz_id: String?//桃汁id
    var nickname: String?//昵称
    var password: String?//密码
    var mobile: String?//手机号
    var avatar: String?//头像
    var gender: Int?////性别(0未知1女2男)
    var birthday: String?//生日
    var bio: String?//签名
    var money: String?//余额
    var balance: String?//桃币余额
    var city: String?//城市
    var province: String?//省份
    var area: String?//地区
    var height: String?//身高(厘米)
    var weight: String?//体重(kg)
    var bust: String?//胸围(厘米)
    var waistline: String?//,腰围(厘米)
    var hips: String?//臀围(厘米)
    var is_model: Int?//0不是模特1是模特
    var expiry_date: String?//会员到期时间
    var is_online: String?//0在线1离线
    var token: String?
    var user_id: String?//用户ID
    var createtime: String?//创建时间
    var expiretime: String?//token过期时间
    var expires_in: String?//Token默认有效时长


    
    

}

extension UserInfoModel {
    
    class func loadUserInfo() -> UserInfoModel? {
        
        let user_data = UserDefaults.standard.data(forKey: userDefaults_userInfo)
        if(user_data != nil){
            let result_dic = NSKeyedUnarchiver.unarchiveObject(with: user_data!) as? NSDictionary
            let userInfoModel = UserInfoModel.deserialize(from: result_dic)
            return userInfoModel
        }
        return nil
        
    }
        
    class func removeUserInfo(){
        
        UserDefaults.standard.set(nil, forKey: userDefaults_userInfo)
        UserDefaults.standard.set(false, forKey: isLogin)
        UserDefaults.standard.synchronize()
//        AppService.shareInstance.unBind_cloudPush_account()//解绑阿里云推送账号
        
    }
    
    
    ///重新登录
    static func afreshLogin(){
    
        if keywindow.viewWithTag(200000) != nil {
            return
        }
        
        
//        let appAlerTipView = AppAlerTipView()
//        appAlerTipView.title_string = "您的登录已过期或账户在其他终端登录!"
//        appAlerTipView.bg_oneView.isHidden = true
//        appAlerTipView.btn_two_string = "重新登录"
//        appAlerTipView.show()
//        appAlerTipView.tag = 200000
//        appAlerTipView.selectIndex = {(select) in
//            if select == 1 {
//                YMKBasicTool.defaultIAPHelper.gotoLogin()
//            }
//        }
        
        
    }
  
}



