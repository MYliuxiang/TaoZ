//
//  Brdging-Header.h
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#ifndef Brdging_Header_h
#define Brdging_Header_h

//导航栏
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"

#import "SDAutoLayout.h"//自动布局
#import <SVProgressHUD/SVProgressHUD.h>
#import <Bugly/Bugly.h>
#import <TZImagePickerController/TZImagePickerController.h>//图片选择器
#import <BRPickerView.h>
#import <YYText/YYText.h>

#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "UIViewController+HUD.h"


#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>

#import "HWPanModal.h"
//极光推送
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//友盟
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMAnalytics/MobClick.h>


#import <AlipaySDK/AlipaySDK.h> //支付宝
#import "WXApi.h"//微信

//apple登录
#import <AuthenticationServices/AuthenticationServices.h>

//融云
#import <RongIMKit/RongIMKit.h>

#endif /* Brdging_Header_h */
