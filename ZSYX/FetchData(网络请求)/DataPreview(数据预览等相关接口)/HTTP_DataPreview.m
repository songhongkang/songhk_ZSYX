//
//  HTTP_DataPreview.m
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "HTTP_DataPreview.h"

@implementation HTTP_DataPreview

+ (void)fetch_index_Information:(NSString *)token withSucceed:(void(^)(NSDictionary *returnDic))succeed failed:(void(^)())failed
{
    NSString *strUrl =  [APIURL stringByAppendingString:@"app/index"];
    NSDictionary *parameterDic = @{@"token":token};
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Month_Information:(NSString *)token withEquipId:(NSString *)equipId withMonth:(NSString *)month withType:(NSString *)type withSucceed:(void (^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    NSString *strUrl =  [APIURL stringByAppendingString:@"equip/use-elec/month-data"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId,
                                   @"month":month,
                                   @"type":type
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}

+ (void)fetch_Year_Information:(NSString *)token withEquipId:(NSString *)equipId withYear:(NSString *)year withSucceed:(void (^)(NSDictionary *returnDic))succeed failed:(void(^)())failed {
    NSString *strUrl =  [APIURL stringByAppendingString:@"equip/use-elec/year-data"];
    NSDictionary *parameterDic = @{@"token":token,
                                   @"equipId":equipId,
                                   @"year":year,
                                   };
    [AFNetworkTool getJSONWithUrl:strUrl parameters:parameterDic success:^(id responseObject) {
        NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeed(returnDic);
    } fail:^{
        failed();
    }];
}
@end
