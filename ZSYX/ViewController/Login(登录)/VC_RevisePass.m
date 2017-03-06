//
//  VC_RevisePass.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_RevisePass.h"

@interface VC_RevisePass ()

@end

@implementation VC_RevisePass
#pragma mark - ====================helper====================
- (void)initData
{

}

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;

}


#pragma mark - ====================Networking====================
- (void)fetch_ReviseAcount_Password
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_Count fetch_ReviseAcount_Password:[Singleton shareInstance].user.token witholdPass:self.textField_oldPassword.text withnewPass:self.textField_NewPassword.text withSucceed:^(NSDictionary *returnDic) {
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
    if ([self.textField_NewPassword.text isEqualToString:self.textField_NewAgainPassword.text]) {
        [self fetch_ReviseAcount_Password];
    }else{
        [MBProgressHUD showError:@"两次输入的密码不一样！"];
    }
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
