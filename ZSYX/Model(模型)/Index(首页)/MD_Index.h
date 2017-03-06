//
//  MD_Index.h
//  ZSYX
//
//  Created by cnmobi on 2016/11/16.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_Index : MD_Base
/// 设备ID
@property (nonatomic, strong) NSString *ID;
/// 设备名称
@property (nonatomic, strong) NSString *equipName;
/// 设备号
@property (nonatomic, strong) NSString *equipNo;
/// 电流
@property (nonatomic, strong) NSString *electricCurrent;
/// 电压
@property (nonatomic, strong) NSString *electricTension;
///  温度（摄氏度）
@property (nonatomic, strong) NSString *boxTemperature;
/// 湿度（%）
@property (nonatomic, strong) NSString *boxHumidity;
//// 功率（kw）
@property (nonatomic, strong) NSString *totalPow;
////电量（%）
@property (nonatomic, strong) NSString *batteryLevel;
/// Wifi状态（1：连接，0：断开）
@property (nonatomic, strong) NSString *wifiStatus;
/// 绑定类型（1：主控，2：从控）
@property (nonatomic, strong) NSString *type;
/// 今日用电量（kw）
@property (nonatomic, strong) NSString *dayUseElectric;
/// 本月用电量
@property (nonatomic, strong) NSString *monthUseElectric;
//// 额定功率
@property (nonatomic, strong) NSString *ratedPower;
///额定电流
@property (nonatomic, strong) NSString *ratedCurrent;
/// 运行时间（h）
@property (nonatomic, strong) NSString *runTime;
///  默认查询设备的开关集合
@property(nonatomic,strong)NSArray *switchs;
/// 最近7天的用电量
@property(nonatomic,strong)NSArray *equipDatas;

@end
