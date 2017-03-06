//
//  VC_ForgetPass.m
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_ForgetPass.h"

@interface VC_ForgetPass ()

@end

@implementation VC_ForgetPass

#pragma mark - ====================helper====================

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

- (void)initData
{
    
    
}


#pragma mark - ====================Networking====================


- (void)fetch_SenderCode_Registered_Acount
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_Count fetch_SenderCode_Registered_Acount:[NSString crypt:self.textField_phone.text] withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            _countDownXib.enabled = NO;
            //button type要 设置成custom 否则会闪动
            [_countDownXib startCountDownWithSecond:60];
            [_countDownXib countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [_countDownXib countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"点击重新获取";
            }];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void)fetch_Find_Password
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_Count fetch_Find_Password:[NSString crypt:self.textField_phone.text] withpassword:[NSString mid5:self.textField_SetPass.text] withcode:self.textField_Code.text withSucceed:^(NSDictionary *returnDic) {
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
- (IBAction)countDownXibTouched:(JKCountDownButton*)sender {
    [self.view endEditing:YES];
    
    if ([NSString validateMobile:self.textField_phone.text]) {
        [self fetch_SenderCode_Registered_Acount];
    }else{
        [MBProgressHUD showError:@"请输入正确的手机号码"];
    }
}

- (IBAction)btnFinishClick:(UIButton *)sender
{
    if (self.textField_phone.text.length == 0  ||
        self.textField_Code.text.length == 0   ||
        self.textField_SetPass.text.length == 0) {
        if (self.textField_phone.text.length == 0 ) {
            [MBProgressHUD showError:@"请输入手机号码"];
        }
        else if (self.textField_Code.text.length == 0 ) {
            [MBProgressHUD showError:@"请输入验证码"];
        }
        else if (self.textField_Code.text.length == 0 ) {
            [MBProgressHUD showError:@"设置新密码"];
        }
    }else{
        if ([NSString validateMobile:self.textField_phone.text]) {
            [self fetch_Find_Password];
        }else{
            [MBProgressHUD showError:@"请输入正确的手机号码"];
        }
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
