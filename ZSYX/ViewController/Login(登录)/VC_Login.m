//
//  VC_Login.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_Login.h"
#import <UMengUShare/WechatAuthSDK.h>
@interface VC_Login ()

@end

@implementation VC_Login

#pragma mark - ====================helper====================

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
    /// 退出登录  me
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_Sina completion:nil];
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:nil];
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:nil];
}

- (void)initData
{
    self.textField_Phone.text = @"13691737124";
    self.textField_Pass.text  = @"1234567";
}

- (void)swithRootViewController
{
    //1、初始化控制器
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_Index *centerVC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Index"];
    
    UIStoryboard *storyboard_storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_SetMain *leftVC = [storyboard_storyboard1 instantiateViewControllerWithIdentifier:@"VC_SetMain"];
    
    UIStoryboard *storyboard_storyboard2 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_SetCenter *rightVC = [storyboard_storyboard2 instantiateViewControllerWithIdentifier:@"VC_SetCenter"];
    
    //2、初始化导航控制器
    UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:centerVC];
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
    UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
    
    //3、使用MMDrawerController
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNvaVC leftDrawerViewController:leftNvaVC rightDrawerViewController:rightNvaVC];
    
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = SCREEN_WIDTH - 100;
    self.drawerController.maximumRightDrawerWidth = SCREEN_WIDTH - 50;
    [UIApplication sharedApplication].delegate.window.rootViewController = self.drawerController;
}

- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)getAuthWithUserInfoFromSina
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
//             授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            [self fetch_Loging_Third:resp.openid withnickName:resp.name withheadImg:resp.iconurl withaccountType:@"2"];
        }
    }];
}

#pragma mark - ====================Networking====================
- (void)fetch_Login_Acount
{
    [MBProgressHUD showMessage:HTTPLOADING toView:self.view];
    [HTTP_Count fetch_Login_Acount:[NSString crypt:self.textField_Phone.text] withpassword:[NSString mid5:self.textField_Pass.text] withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([returnDic[@"code"] integerValue] == 0) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [Singleton shareInstance].user = [User mj_objectWithKeyValues:returnDic[@"result"]];
            [self swithRootViewController];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void)fetch_Loging_Third:(NSString *)openid withnickName:(NSString *)nickName withheadImg:(NSString *)headImg withaccountType:(NSString *)accountType
{
    [MBProgressHUD showMessage:HTTPLOADING toView:self.view];
    [HTTP_Count fetch_Loging_Third:openid withnickName:nickName withheadImg:headImg withaccountType:accountType withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [Singleton shareInstance].user = [User mj_objectWithKeyValues:returnDic[@"result"]];
            [self swithRootViewController];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================BtnClick====================

- (IBAction)btnToLoginClick:(UIButton *)sender
{
    if (self.textField_Pass.text.length ==0  ||
        self.textField_Phone.text.length ==0) {
        
         if (self.textField_Phone.text.length == 0) {
            [MBProgressHUD showError:@"请输入手机号码"];
        }
        else if (self.textField_Pass.text.length == 0) {
             [MBProgressHUD showError:@"请输入密码"];
        }
    }else{
        [self fetch_Login_Acount];
    }
}

- (IBAction)btnThirdLoginClick:(UIButton *)sender
{
    if (sender.tag - 100 == 0) { //wechat
        [self getAuthWithUserInfoFromWechat];
    }
    if (sender.tag - 100 == 1) { //webo
        [self getAuthWithUserInfoFromSina];
    }
    if (sender.tag - 100 == 2) { //qq
        [self getAuthWithUserInfoFromQQ];
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
