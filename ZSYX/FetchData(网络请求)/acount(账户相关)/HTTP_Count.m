//
//  HTTP_Count.m
//  ZSYX
//
//  Created by cnmobi on 16/11/3.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "HTTP_Count.h"

@implementation HTTP_Count

+ (void)fetch_SenderCode_NoRegister_Acount:(NSString *)phone withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"open/register/captcha/get"];
    NSDictionary *parameterDic = @{@"phone":phone};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Register_Acount:(NSString *)phone withpassword:(NSString *)password withcode:(NSString *)code withnickname:(NSString *)nickname withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"open/user/register"];
    NSDictionary *parameterDic = @{@"phone":phone,
                                   @"password":password,
                                   @"code":code,
                                   @"nickname":nickname};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Login_Acount:(NSString *)phone withpassword:(NSString *)password  withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"open/user/login"];
    NSDictionary *parameterDic = @{@"phone":phone,
                                   @"password":password};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Loging_Third:(NSString *)openId withnickName:(NSString *)nickName withheadImg:(NSString *)headImg withaccountType:(NSString *)accountType withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"open/user/thirdLogin"];
    NSDictionary *parameterDic = @{@"openId":openId,
                                   @"nickName":nickName,
                                   @"headImg":headImg,
                                   @"accountType":accountType};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Exit_Loging:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/logout"];
    NSDictionary *parameterDic = @{@"token":token};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_FindAcount_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/info/get"];
    NSDictionary *parameterDic = @{@"token":token};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_ReviseAcount_Information:(NSString *)token withnickName:(NSString *)nickName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/info/reset"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"nickName":nickName};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_ReviseAcount_Information:(NSString *)token withImageArr:(NSArray *)array_image withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/headImg/update"];
    NSDictionary *parameterDic = @{@"token":token};
    
    [AFNetworkTool postUploadWithUrl:strUrl fileDataArr:array_image parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_ReviseAcount_Password:(NSString *)token witholdPass:(NSString *)oldPass withnewPass:(NSString *)newPass withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/info/reset"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"oldPass":oldPass,
                                   @"newPass":newPass};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_SenderCode_Registered_Acount:(NSString *)phone withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"open/forget/captcha/get"];
    NSDictionary *parameterDic = @{@"phone":phone};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Find_Password:(NSString *)phone withpassword:(NSString *)password withcode:(NSString *)code withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"user/forget/password/reset"];
    NSDictionary *parameterDic = @{@"phone":phone,
                                   @"password":password,
                                   @"code":code};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

@end

