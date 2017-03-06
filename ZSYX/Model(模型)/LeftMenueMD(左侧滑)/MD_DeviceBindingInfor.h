//
//  MD_DeviceBindingInfor.h
//  ZSYX
//
//  Created by cnmobi on 2016/11/18.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_DeviceBindingInfor : MD_Base
///用户ID
@property (nonatomic, strong) NSString *userId;
///用户昵称
@property (nonatomic, strong) NSString *nickName;
/// 类型（1：主控，2：从控）
@property (nonatomic, strong) NSString *type;

@end
