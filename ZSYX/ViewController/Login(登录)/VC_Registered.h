//
//  VC_Registered.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

/// 注册界面

#import "VC_Base.h"
#import "JKCountDownButton.h"



@interface VC_Registered : VC_Base

/// 控制UISCROLLERVIEW的滚动
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;

/// 输入昵称
@property IBOutlet UITextField * textField_nickName;
/// 手机号码
@property IBOutlet UITextField * textField_phone;
/// 验证码
@property IBOutlet UITextField * textField_Code;
/// 设置新密码
@property IBOutlet UITextField * textField_SetPass;
/// 倒计时按钮
@property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;

@end
