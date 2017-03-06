//
//  VC_Base.m
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_Base.h"

@interface VC_Base ()

@end

@implementation VC_Base

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationAndTabbarAttribute];
    self.view.backgroundColor = RGB(44, 44, 57);
    
    [self initData];
    [self initLayout];
}

- (BOOL) prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
    
}

/**
 初始化一些数据吧
 */
- (void)initData
{

}
/**
 初始化一些东西吧
 */
- (void)initLayout
{
    
}
/**
 设置NAVIGATION 的颜色
 */
- (void)setNavigationAndTabbarAttribute
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = SubjectColor;
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = SubjectColor;
}
/**
 让所有页面键盘显示
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
