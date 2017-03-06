//
//  VC_2DCodeInvitesFamilyMembers.h
//  ZSYX
//
//  Created by cnmobi on 2016/11/17.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 二维码扫描

#import "VC_Base.h"

@interface VC_2DCodeInvitesFamilyMembers : VC_Base
/// ScrollerviewHeight
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;
/// 二维码的imageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2WeiMa;
/// 二维码的信息
@property NSString *string_2WeiCodeInfor;

@end
