//
//  VC_ForgetPass.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 忘记密码

#import "VC_Base.h"
#import "JKCountDownButton.h"

@interface VC_ForgetPass : VC_Base

/// 控制UISCROLLERVIEW的滚动
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;
/// 手机号码
@property IBOutlet UITextField * textField_phone;
/// 验证码
@property IBOutlet UITextField * textField_Code;
/// 设置新密码
@property IBOutlet UITextField * textField_SetPass;
/// 倒计时按钮
@property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;

@end
