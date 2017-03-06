//
//  VC_ReviseNickName.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_ReviseNickName.h"

@interface VC_ReviseNickName ()

@end

@implementation VC_ReviseNickName


#pragma mark - ====================helper====================

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)initData
{
    
}

- (void)initLayout
{
    [self.textField_NickName becomeFirstResponder];
    self.textField_NickName.text = [Singleton shareInstance].user.nickName;
}


#pragma mark - ====================Networking====================

- (void)fetch_ReviseAcount_Information
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_Count fetch_ReviseAcount_Information:[Singleton shareInstance].user.token withnickName:self.textField_NickName.text withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [Singleton shareInstance].user.nickName = self.textField_NickName.text;
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================BtnClick====================

- (IBAction)btnSaveInformationClick:(UIButton *)sender
{
    [self fetch_ReviseAcount_Information];
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
