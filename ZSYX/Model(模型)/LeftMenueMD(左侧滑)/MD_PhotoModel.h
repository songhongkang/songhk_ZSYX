//
//  MD_PhotoModel.h
//  ZSYX
//
//  Created by cnmobi on 16/11/29.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_PhotoModel : MD_Base
/// String	Id
@property (nonatomic,strong) NSString *ID;
/// String	模式（0：非相框模式，1：半屏相框模式，2：全屏相框模式）
@property (nonatomic,strong) NSString *model;
/// 照片切换时间（单位：秒）
@property (nonatomic,strong) NSString *phoneExchangeTime;
/// 相框持续时间（单位：小时）
@property (nonatomic,strong) NSString *modelLastTime;
/// 设备id
@property (nonatomic,strong) NSString *equipId;


@end
