//
//  HTTP_DataPreview.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkTool.h"
#import "MainHeader.h"
@interface HTTP_DataPreview : NSObject
/**
 *  2.3.1	首页
 *  @param token          手机令牌
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_index_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.3.2	月度数据查询
 *  @param token            手机令牌
 *  @param month            月份（格式：yyyy-MM）
 *  @param equipId          设备ID
 *  @param type             类型(electricCurrent：电流 electricTension：电压
                            boxTemperature：箱体温度
                            boxHumidity：箱体湿度
                            batteryLevel：电池电量totalPow：功率
                            useElectric：用电量)
 *  @param succeed        成功
 *  @param failed         失败
 */
+ (void)fetch_Month_Information:(NSString *)token withEquipId:(NSString *)equipId withMonth:(NSString *)month withType:(NSString *)type withSucceed:(void (^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 *  2.3.3	查询年度用电量
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param year             年
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Year_Information:(NSString *)token withEquipId:(NSString *)equipId withYear:(NSString *)year withSucceed:(void (^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;




@end
