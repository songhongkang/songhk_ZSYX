//
//  MD_TimeSetupInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/11/29.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_TimeSetupInfor : MD_Base

@property (nonatomic,strong) NSString *ID;
/// 省
@property (nonatomic,strong) NSString *provinceName;
/// 市
@property (nonatomic,strong) NSString *cityName;
/// 是否24小时制（1：是，0：不是）
@property (nonatomic,strong) NSString *isTwentyFour;
/// 是否自动设置时间（1：是，0：否）
@property (nonatomic,strong) NSString *isAutoSetup;
/// 时区
@property (nonatomic,strong) NSString *timeZone;
/// 日期
@property (nonatomic,strong) NSString *nowDate;
/// 时间
@property (nonatomic,strong) NSString *nowTime;
/// 设备id
@property (nonatomic,strong) NSString *equipId;
/// String	时区
@property (nonatomic,strong) NSString *timeZoneId;
/// 时区名
@property (nonatomic,strong) NSString *timeZoneName;


@end
