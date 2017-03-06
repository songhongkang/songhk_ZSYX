//
//  VC_Login.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

///登录界面

#import "VC_Base.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "VC_Index.h"
#import "VC_SetMain.h"
#import "VC_SetCenter.h"
#import "User.h"
#import <UMengUShare/UMSocialQQHandler.h>
#import <UMengUShare/UMSocialSinaHandler.h>
#import <UMengUShare/UMSocialWechatHandler.h>
#import <UMSocialCore/UMSocialCore.h>



@interface VC_Login : VC_Base

/// 侧滑组件
@property(nonatomic,strong) MMDrawerController * drawerController;
/// ScrollerviewHeight
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;
/// 输入手机号码
@property IBOutlet UITextField *textField_Phone;
/// 输入密码
@property IBOutlet UITextField *textField_Pass;

@end
