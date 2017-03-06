//
//  VC_Guide.m
//  ZSYX
//
//  Created by cnmobi on 16/11/24.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_Guide.h"



@interface VC_Guide ()

@end

@implementation VC_Guide

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [HTTP_SettingInfor fetch_Change_PhotoFrmeSetting:[Singleton shareInstance].user.token withEquipId:@"15ef2b11ab304849836973c8f8b155d6" withModel:@"0" withPhoneExchangeTime:@"6" withModelLastTime:@"1" withSucceed:^(NSDictionary *returnDic) {
        
    } failed:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
