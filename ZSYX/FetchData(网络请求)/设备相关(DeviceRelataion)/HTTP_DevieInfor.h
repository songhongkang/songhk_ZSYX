//
//  HTTP_DevieInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkTool.h"
#import "MainHeader.h"


@interface HTTP_DevieInfor : NSObject
/**
 *  2.2.1	主控绑定设备
 *  @param token            手机令牌
 *  @param equipNo          设备号
 *  @param equipName        设备名称
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_mainCtrl_Device_Banding:(NSString *)token withequipNo:(NSString *)equipNo withequipName:(NSString *)equipName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.2.2	主控获取邀请绑定验证码
 *  @param token           手机令牌
 *  @param equipId          设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_mainCtrl_Device_InvitationCode:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.2.3	从控绑定设备
 *  @param token            手机令牌
 *  @param code             验证码
 *  @param phoneType        手机类型（如：iphone，小米）
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Ctrl_Device_Banding:(NSString *)token withcode:(NSString *)code withphoneType:(NSString *)phoneType withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.2.4	查询指定设备已绑定用户列表
 *  @param token           手机令牌
 *  @param equipId         设备ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_BindEquip_Device_UserList:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.2.5	修改设备名字
 *  @param token           手机令牌
 *  @param equipId         设备ID
 *  @param equipName       设备名
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Update_Device_EquipName:(NSString *)token withequipId:(NSString *)equipId withequipName:(NSString *)equipName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.2.6	取消共享
 *  @param token           手机令牌
 *  @param equipId         设备ID
 *  @param userId          用户ID
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_MainCtrl_Device_Unbind:(NSString *)token withequipId:(NSString *)equipId withuserId:(NSString *)userId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;


/**
 2.2.7	从控解绑

 @param token 手机令牌
 @param equipId 设备ID
 @param succeed 成功
 @param failed 失败
 */
+ (void)fetch_Ctrl_Device_Unbind:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

@end
