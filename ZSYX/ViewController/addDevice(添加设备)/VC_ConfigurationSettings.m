//
//  VC_ConfigurationSettings.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 配置设备

#import "VC_ConfigurationSettings.h"

@interface VC_ConfigurationSettings ()

@end

@implementation VC_ConfigurationSettings

#pragma mark - ====================helper====================

- (void)initData
{
    
}

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

#pragma mark - ====================Networking====================

- (void)fetch_mainCtrl_Device_Banding
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_mainCtrl_Device_Banding:[Singleton shareInstance].user.token withequipNo:@"2e57d916a59043c09c24c6da43761ab4" withequipName:self.textField_equipName.text withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}


#pragma mark - ====================BtnClick====================
- (IBAction)btnClick:(UIButton *)sender
{
//    [NOTIFY postNotificationName:ConfigurationSettingsNotifcation object:@[@"3"]];
    [self fetch_mainCtrl_Device_Banding];
    
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
