//
//  HTTP_SettingInfor.m
//  ZSYX
//
//  Created by cnmobi on 16/11/24.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "HTTP_SettingInfor.h"

@implementation HTTP_SettingInfor

+ (void) fetch_change_CircuitSetting:(NSString *)token withequipNo:(NSString *)equipNo withratedCurrent:(NSString *)ratedCurrent withratedPower:(NSString *)ratedPower withswitchs:(NSArray *)switchs  withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:[NSString stringWithFormat:@"open/baseInfo/update?token=%@",token]] ;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:token forKey:@"token"];
    [parameters setValue:equipNo forKey:@"equipNo"];
    [parameters setValue:ratedCurrent forKey:@"ratedCurrent"];
    [parameters setValue:ratedPower forKey:@"ratedPower"];
    [parameters setValue:switchs forKey:@"switchs"];
    
    [AFNetworkTool postJSONWithUrl:strUrl parameters:parameters success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}


+ (void) fetch_Screensaver_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed{
    NSString *strUrl =  [APIURL stringByAppendingString:@"screensaverImg/list"];
    NSDictionary *parameterDic = @{@"token":token};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_ScreenSetting:(NSString *)token withEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    NSString *strUrl =  [APIURL stringByAppendingString:@"screensaver/setup/info"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_Change_ScreenSetting:(NSString *)token withEquipId:(NSString *) equipId withscreenLight:(NSString *)screenLight withIsOpenLight:(NSString *)isOpenLight withStartLightTime:(NSString *)startLightTime withEndLightTime:(NSString *)endLightTime withAutoCloseLight:(NSString *)autoCloseLight withOpenScreensaverTime:(NSString *)openScreensaverTime withScreensaverImgId:(NSString *)screensaverImgId withisOpenScreensaver:(NSString *)isOpenScreensaver withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed{
    NSString *strUrl =  [APIURL stringByAppendingString:@"screensaver/setup/update"];
    NSMutableDictionary *parameterDic = [NSMutableDictionary dictionary];
    
    [parameterDic setValue:token forKey:@"token"];
    [parameterDic setValue:equipId forKey:@"equipId"];
    [parameterDic setValue:screenLight forKey:@"screenLight"];
    [parameterDic setValue:isOpenLight forKey:@"isOpenLight"];
    [parameterDic setValue:startLightTime forKey:@"startLightTime"];
    [parameterDic setValue:endLightTime forKey:@"endLightTime"];
    [parameterDic setValue:autoCloseLight forKey:@"autoCloseLight"];
    [parameterDic setValue:openScreensaverTime forKey:@"openScreensaverTime"];
    [parameterDic setValue:screensaverImgId forKey:@"screensaverImgId"];
    [parameterDic setValue:isOpenScreensaver forKey:@"isOpenScreensaver"];

    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_Query_TimeSetting:(NSString *)token ithEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    NSString *strUrl =  [APIURL stringByAppendingString:@"timeSetup/info"];
    NSDictionary *parameterDic = @{@"token" : token,
                                   @"equipId" : equipId,
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_Change_TimeSetting:(NSString *)token withEquipId:(NSString *) equipId withProvinceName:(NSString *)provinceName withCityName:(NSString *)cityName withIsTwentyFour:(NSString *)isTwentyFour withIsAutoSetup:(NSString *)isAutoSetup withTimeZone:(NSString *)timeZone withNowDate:(NSString *)nowDate withNowTime:(NSString *)nowTime withtimeZoneId:(NSString *)timeZoneId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"timeSetup/update"];
    
    NSDictionary *parameterDic = @{@"token" : token,
                                   @"equipId" : equipId,
                                   @"provinceName":provinceName,
                                   @"cityName" : cityName,
                                   @"isTwentyFour" : isTwentyFour,
                                   @"isAutoSetup" : isAutoSetup,
                                   @"timeZoneName" : timeZone,
                                   @"timeZoneId" : timeZoneId,
                                   @"nowDate" : nowDate,
                                   @"nowTime" : nowTime
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_Query_PhotoFrameSetting:(NSString *)token withEquipId:(NSString *) equipId withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    NSString *strUrl =  [APIURL stringByAppendingString:@"phontoFrameSetup/info"];
    NSDictionary *parameterDic = @{@"token" : token,
                                   @"equipId" : equipId,
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void) fetch_Change_PhotoFrmeSetting:(NSString *)token withEquipId:(NSString *) equipId withModel:(NSString *)model withPhoneExchangeTime:(NSString *)phoneExchangeTime withModelLastTime:(NSString *)modelLastTime withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    
    NSString *strUrl =  [APIURL stringByAppendingString:@"phontoFrameSetup/update"];
    
    NSDictionary *parameterDic = @{@"token" : token,
                                   @"equipId" : equipId,
                                   @"model" : model,
                                   @"phoneExchangeTime" : phoneExchangeTime,
                                   @"modelLastTime" : modelLastTime,
                                   };
    NSLog(@"parameterDic  ----->%@",parameterDic);
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

@end
