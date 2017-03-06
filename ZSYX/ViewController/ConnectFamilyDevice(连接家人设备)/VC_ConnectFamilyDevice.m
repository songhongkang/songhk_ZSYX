//
//  VC_ConnectFamilyDevice.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_ConnectFamilyDevice.h"

@interface VC_ConnectFamilyDevice ()

@end

@implementation VC_ConnectFamilyDevice

#pragma mark - ====================helper====================

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

- (void)initData
{
    
    
}

#pragma mark - ====================network====================
- (void)fetch_Ctrl_Device_Banding:(NSString *)stringValue
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_Ctrl_Device_Banding:[Singleton shareInstance].user.token withcode:stringValue withphoneType:@"iphone" withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================btnClick====================

- (IBAction)btnClick:(UIButton *)sender
{
    HMScannerController *scanner = [HMScannerController scannerWithCardName:nil avatar:nil completion:^(NSString *stringValue) {
        NSLog(stringValue,nil)
        [self fetch_Ctrl_Device_Banding:stringValue];
    }];
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    [self showDetailViewController:scanner sender:nil];
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
