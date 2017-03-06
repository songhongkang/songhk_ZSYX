//
//  HTTP_SettingInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/11/24.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkTool.h"
#import "MainHeader.h"

@interface HTTP_SettingInfor : NSObject
/**
 2.4.1	线路设置

 @param token 手机令牌
 @param equipNo 手机令牌
 @param ratedCurrent 额定电流
 @param ratedPower 额定功率
 @param switchs 修改的开关集合
 @param switchNo 开关编号
 @param name 开关编号
 @param succeed 成功
 @param failed 失败
 */
+ (void) fetch_change_CircuitSetting:(NSString *)token withequipNo:(NSString *)equipNo withratedCurrent:(NSString *)ratedCurrent withratedPower:(NSString *)ratedPower withswitchs:(NSArray *)switchs  withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;


/**
 *  2.4.2	查询屏保图列表
 *  @param token            手机令牌
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_Screensaver_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 *  2.4.3	查询屏幕设置
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_ScreenSetting:(NSString *)token withEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 2.4.4	修改屏幕设置

 @param token 手机令牌
 @param equipId 设备ID
 @param screenLight 屏幕亮度（0-100之间的整数）
 @param isOpenLight 是否开启屏幕点亮时间段（1：是，0：否）
 @param startLightTime 屏幕点亮开始时间
 @param endLightTime 屏幕点亮结束时间
 @param autoCloseLight 自动熄屏时间（0：永不熄灭）
 @param openScreensaverTime 进入屏保时间
 @param screensaverImgId 屏保图ID
 @param succeed 成功
 @param failed 失败
 */
+ (void) fetch_Change_ScreenSetting:(NSString *)token withEquipId:(NSString *) equipId withscreenLight:(NSString *)screenLight withIsOpenLight:(NSString *)isOpenLight withStartLightTime:(NSString *)startLightTime withEndLightTime:(NSString *)endLightTime withAutoCloseLight:(NSString *)autoCloseLight withOpenScreensaverTime:(NSString *)openScreensaverTime withScreensaverImgId:(NSString *)screensaverImgId withisOpenScreensaver:(NSString *)isOpenScreensaver withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 *  2.4.5	查询时间设置
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_Query_TimeSetting:(NSString *)token ithEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 *  2.4.6	修改时间设置
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_Change_TimeSetting:(NSString *)token withEquipId:(NSString *) equipId withProvinceName:(NSString *)provinceName withCityName:(NSString *)cityName withIsTwentyFour:(NSString *)isTwentyFour withIsAutoSetup:(NSString *)isAutoSetup withTimeZone:(NSString *)timeZone withNowDate:(NSString *)nowDate withNowTime:(NSString *)nowTime withtimeZoneId:(NSString *)timeZoneId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.4.7	查询相框设置
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_Query_PhotoFrameSetting:(NSString *)token withEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.4.8	修改相框设置
 *  @param token            手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void) fetch_Change_PhotoFrmeSetting:(NSString *)token withEquipId:(NSString *) equipId withModel:(NSString *)model withPhoneExchangeTime:(NSString *)phoneExchangeTime withModelLastTime:(NSString *)modelLastTime withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

@end
