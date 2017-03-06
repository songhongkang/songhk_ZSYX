//
//  MD_Switchs.h
//  ZSYX
//
//  Created by cnmobi on 2016/11/16.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_Switchs : MD_Base

@property (nonatomic, strong) NSString *ID;
/// 设备ID
@property (nonatomic, strong) NSString *equipId;
/// 设变编号
@property (nonatomic, strong) NSString *switchNo;
/// 排序
@property (nonatomic, strong) NSString *sequence;
/// 开关名字
@property (nonatomic, strong) NSString *switchName;
/// 开关状态
@property (nonatomic, strong) NSString *status;

@end
