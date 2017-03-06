//
//  VC_InviteFamily.m
//  ZSYX
//
//  Created by cnmobi on 16/11/10.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_InviteFamily.h"

@interface VC_InviteFamily ()
{
    NSString *string_CodeInvite;
}
@end

@implementation VC_InviteFamily

#pragma mark - ====================helper====================

- (void)initData
{

}

- (void)initLayout
{
    [self fetch_mainCtrl_Device_InvitationCode];
}

#pragma mark - ====================Fetch====================
- (void)fetch_mainCtrl_Device_InvitationCode
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_mainCtrl_Device_InvitationCode:[Singleton shareInstance].user.token withequipId:[kUserDefaults objectForKey:@"equipID"]  withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            string_CodeInvite = returnDic[@"result"];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================TableViewDelegate====================

- (void)shareSheet:(FSShareSheet *)shareView clickedButtonAtIndex:(NSInteger)index
{
    NSLog(@"===============%ld",index);
    switch (index) {
        case 1:
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"weixin://"]]){
                NSLog(@"install--");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"点击复制邀请码:%@",string_CodeInvite] message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction_Ok = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    [pasteboard setString:[NSString stringWithFormat:@"%@",string_CodeInvite]];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
                }];
                UIAlertAction *alertAction_Cancle = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController addAction:alertAction_Ok];
                [alertController addAction:alertAction_Cancle];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }else{
                NSLog(@"no---");
                [MBProgressHUD showError:@"没有安装微信"];
            }
            break;
        case 2:
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"sms://"]]){
                NSLog(@"install--");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"点击复制邀请码:%@",string_CodeInvite] message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction_Ok = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    [pasteboard setString:[NSString stringWithFormat:@"%@",string_CodeInvite]];

                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://"]];
                }];
                UIAlertAction *alertAction_Cancle = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController addAction:alertAction_Ok];
                [alertController addAction:alertAction_Cancle];
                [self presentViewController:alertController animated:YES completion:nil];

            }else{
                NSLog(@"no---");
                [MBProgressHUD showError:@"没有安装微信"];
            }
            break;
        case 3:
        {
            [self performSegueWithIdentifier:@"push_VC_2DCodeInvitesFamilyMembers" sender:string_CodeInvite];
        }
            break;
        default:
            break;
    }
}


#pragma mark - ====================btnClick====================
- (IBAction)btnClick:(id)sender
{
    FSShareSheet *shareSheet = [[FSShareSheet alloc] initWithTitle:@"邀请家人：" delegate:self cancelButtonTitle:nil];
    [shareSheet show];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"push_VC_2DCodeInvitesFamilyMembers"]) {
        [(VC_2DCodeInvitesFamilyMembers *)segue.destinationViewController setString_2WeiCodeInfor:[NSString stringWithFormat:@"%@",sender]];
    }
}


@end
