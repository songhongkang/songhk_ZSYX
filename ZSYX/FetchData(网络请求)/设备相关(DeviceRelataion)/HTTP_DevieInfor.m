//
//  HTTP_DevieInfor.m
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "HTTP_DevieInfor.h"

@implementation HTTP_DevieInfor

+ (void)fetch_mainCtrl_Device_Banding:(NSString *)token withequipNo:(NSString *)equipNo withequipName:(NSString *)equipName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"bind/equip/mainCtrl"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipNo":equipNo,
                                   @"equipName":equipName};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_mainCtrl_Device_InvitationCode:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed;
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"bind/invitation/code"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Ctrl_Device_Banding:(NSString *)token withcode:(NSString *)code withphoneType:(NSString *)phoneType withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"bind/invitation/check"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"code":code,
                                   @"phoneType":phoneType};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_BindEquip_Device_UserList:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"bindEquip/userList"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Update_Device_EquipName:(NSString *)token withequipId:(NSString *)equipId withequipName:(NSString *)equipName withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"equip/updateEquipName"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId,
                                   @"equipName":equipName};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_MainCtrl_Device_Unbind:(NSString *)token withequipId:(NSString *)equipId withuserId:(NSString *)userId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"mainCtrl/unbind"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId,
                                   @"userId":userId};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Ctrl_Device_Unbind:(NSString *)token withequipId:(NSString *)equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"viceCtrl/unbind"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId};
    
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}
@end
