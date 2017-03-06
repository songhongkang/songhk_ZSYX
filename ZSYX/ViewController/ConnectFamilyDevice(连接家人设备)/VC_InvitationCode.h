//
//  VC_InvitationCode.h
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 邀请家人


#import "VC_Base.h"

@interface VC_InvitationCode : VC_Base
/// scrollerView Heigt
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;
/// 邀请码
@property IBOutlet UITextField *textField_InviteCode;
@end
