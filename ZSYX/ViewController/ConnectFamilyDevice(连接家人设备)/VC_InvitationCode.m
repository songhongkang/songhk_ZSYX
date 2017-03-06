//
//  VC_InvitationCode.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_InvitationCode.h"

@interface VC_InvitationCode ()

@end

@implementation VC_InvitationCode

#pragma mark - ====================helper====================

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

- (void)initData
{
    
    
}

#pragma mark - ====================Networking====================

- (void)fetch_Ctrl_Device_Banding
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_Ctrl_Device_Banding:[Singleton shareInstance].user.token withcode:self.textField_InviteCode.text withphoneType:@"iphone" withSucceed:^(NSDictionary *returnDic) {
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


#pragma mark - ====================BtnClick====================
- (IBAction)btnFinishClick:(id)sender
{
    [self fetch_Ctrl_Device_Banding];
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
