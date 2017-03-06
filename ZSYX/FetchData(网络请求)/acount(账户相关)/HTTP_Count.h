//
//  HTTP_Count.h
//  ZSYX
//
//  Created by cnmobi on 16/11/3.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkTool.h"
#import "MainHeader.h"

@interface HTTP_Count : NSObject

/**
 *  2.1.1	未注册账户发送短信验证码
 *  @param phone            手机号
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_SenderCode_NoRegister_Acount:(NSString *)phone withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/**
 * 2.1.2	注册
 *  @param phone            手机号
 *  @param nickname         昵称
 *  @param password         密码
 *  @param code            验证码
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Register_Acount:(NSString *)phone withpassword:(NSString *)password withcode:(NSString *)code withnickname:(NSString *)nickname withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
/**
 *  2.1.3	登录
 *  @param phone            手机号
 *  @param password         密码
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Login_Acount:(NSString *)phone withpassword:(NSString *)password  withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.4	三方登录
 *  @param openId           三方登录标志
 *  @param nickName         昵称
 *  @param headImg          头像地址
 *  @param accountType      账号类别
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Loging_Third:(NSString *)openId withnickName:(NSString *)nickName withheadImg:(NSString *)headImg withaccountType:(NSString *)accountType withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.5	退出登录
 *  @param token           手机令牌
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Exit_Loging:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.6	查询账户信息
 *  @param token           手机令牌
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_FindAcount_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.7	修改用户信息
 *  @param token           手机令牌
 *  @param nickName        昵称
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_ReviseAcount_Information:(NSString *)token withnickName:(NSString *)nickName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.8	修改头像
 *  @param token           手机令牌
 *  @param array_image      头像文件
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_ReviseAcount_Information:(NSString *)token withImageArr:(NSArray *)array_image withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.9	修改密码
 *  @param token           手机令牌
 *  @param oldPass          密码
 *  @param newPass           新密码
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_ReviseAcount_Password:(NSString *)token witholdPass:(NSString *)oldPass withnewPass:(NSString *)newPass withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** *  2.1.10	已注册账户发验证码
 *  @param phone           手机号码
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_SenderCode_Registered_Acount:(NSString *)phone withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

/** * 2.1.11	找回密码
 *  @param phone            手机号码
 *  @param password         密码
 *  @param code             验证码
 *  @param succeed          成功
 *  @param failed           失败
 */
+ (void)fetch_Find_Password:(NSString *)phone withpassword:(NSString *)password withcode:(NSString *)code withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;

@end
