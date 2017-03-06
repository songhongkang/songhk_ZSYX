//
//  AppDelegate.m
//  ZSYX
//
//  Created by cnmobi on 16/10/26.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "VC_Index.h"
#import "VC_SetMain.h"
#import "VC_SetCenter.h"
#import <UMMobClick/MobClick.h>
#import <UMengUShare/UMSocialQQHandler.h>
#import "DWGuidePage.h"
#import "VC_GuidePage.h"

@interface AppDelegate ()

@property(nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /// 友盟统计
    UMConfigInstance.appKey = @"5819d360a325112dfc00244e";
    UMConfigInstance.channelId = @"cnmobi";
    UMConfigInstance.eSType = E_UM_GAME; // 仅适用于游戏场景
    [MobClick startWithConfigure:UMConfigInstance];
    /// 华移权限代码
    [[CnmobiAppManagement ManagementInit]ManagementWithAppName:@"davisbrain"];

    /// 第三方登录一些代码
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5819d360a325112dfc00244e"];
    //设置新浪的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"775715587"  appSecret:@"1e66cdc12beb75314f71cdb551e2bca8" redirectURL:@"https://api.weibo.com/oauth2/default.html"];
    
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105781514"  appSecret:@"4NsrNT4XHSVoXvqS" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfb4997a410367f52" appSecret:@"2f80712a81dcf75ffe04d49d2b26dd07" redirectURL:@"http://mobile.umeng.com/social"];

    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_Login *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Login"];
    UINavigationController *NvaVC = [[UINavigationController alloc]initWithRootViewController:VC];
    ///7、设置启动页
    [DWGuidePage dw_AppDelegateGuidePageWindow:self.window guidePageVC:[VC_GuidePage new] mainVC:NvaVC];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setRootViewController:(NSNotification *)sender
{
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_Login *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Login"];
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:VC];
    [self.window setRootViewController:leftNvaVC];
}

/**
 Resign:辞职   app即将进入非激活状态(Inactive),还在前台

 @param application 应用程序本身
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 app已经进入后台(Background)

 @param application app
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
