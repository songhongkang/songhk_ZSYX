//
//  MD_ScreenSetupInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/11/30.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_ScreenSetupInfor : MD_Base

@property (nonatomic,strong) NSString *ID;
/// 屏幕亮度（0-100之间的整数）
@property (nonatomic,strong) NSString *screenLight;
/// 是否开启屏幕点亮时间段（1：是，0：否）
@property (nonatomic,strong) NSString *isOpenLight;
/// 屏幕点亮开始时间
@property (nonatomic,strong) NSString *startLightTime;
/// 屏幕点亮结束时间
@property (nonatomic,strong) NSString *endLightTime;
/// 自动熄屏时间（0：永不熄灭）
@property (nonatomic,strong) NSString *autoCloseLight;
/// 是否开启屏幕点亮时间段（1：是，0：否）
@property (nonatomic,strong) NSString *isOpenScreensaver;
/// 进入屏保时间
@property (nonatomic,strong) NSString *openScreensaverTime;
///  设备id
@property (nonatomic,strong) NSString *equipId;
/// 屏保图ID
@property (nonatomic,strong) NSString *screensaverImgId;

@end
