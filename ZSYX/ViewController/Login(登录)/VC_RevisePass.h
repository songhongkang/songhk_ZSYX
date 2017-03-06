//
//  VC_RevisePass.h
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

/// 密码重置

#import "VC_Base.h"

@interface VC_RevisePass : VC_Base
/// 控制UISCROLLERVIEW的滚动
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;

/// 设置原密码
@property IBOutlet UITextField * textField_oldPassword;
/// 设置新密码
@property IBOutlet UITextField * textField_NewPassword;
/// 设置再一次新密码
@property IBOutlet UITextField * textField_NewAgainPassword;

@end
