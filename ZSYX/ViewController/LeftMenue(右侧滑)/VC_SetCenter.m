//
//  VC_SetCenter.m
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_SetCenter.h"

@interface VC_SetCenter ()
{
    /// tablevie Img
    NSArray *array_DataImg;
    /// tableview Title
    NSArray *array_DataTitle;
    /// tableview headerView
    View_PersonalCenter *view;
    /// 用户传值的字典
    NSDictionary *dict_Infor;
}
@end

@implementation VC_SetCenter

#pragma mark - ====================helper====================

- (void)viewWillAppear:(BOOL)animated
{
    [view.button_Header sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].user.headImg] forState:UIControlStateNormal placeholderImage:Picture_Default];
    view.label_Phone.text = [Singleton shareInstance].user.phone;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)initData
{
    [self setStatusBarBackgroundColor:SubjectColor];
//    [self setStatusBarBackgroundColor:RGB(44, 44, 57)];
    
    array_DataImg = @[@"iconfont_tianjiashebei",@"iconfont_xiaoxizhongxin",@"iconfont_shebeizhinan",@"iconfont-guanyu",@"iconfont_ruanjiebanben",@"iconfont_tuichudenglu"];
    
    array_DataTitle = @[@"添加设备",@"消息中心",@"使用设备指南",@"关于我们",@"软件版本",@"退出登录"];
}

- (void)initLayout
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    view = [[NSBundle mainBundle]loadNibNamed:@"View" owner:self options:nil][0];

    HK_WeakSelf;
    view.BlockClick = ^()
    {
        UINavigationController* nav = (UINavigationController*)weakSelf.mm_drawerController.centerViewController;
        UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        VC_AcountManager *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_AcountManager"];
        [nav pushViewController:VC animated:NO];
        [weakSelf.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [weakSelf.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    };
    [self.tableView_List addSpringHeadView:view];
    /// 设置导航栏的颜色
//    self.navigationController.navigationBar.barTintColor = RGBA(44, 44, 57, 0);
    self.navigationController.delegate = self;
}

#pragma mark - ====================Delegate====================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.row == 5) {
        /// 弹出自定义alertview
        HKAlertView *hkalertView = [[HKAlertView alloc] initWithTitle:@"您确定退出登录吗?" withPlaceHoldTextField:nil sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:NO withFinalyProperty:nil];
        
        hkalertView.delegate = self;
        [hkalertView showHKAlertView];
    }
    if (indexPath.row == 0) {

        VC_Add *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Add"];
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:VC animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    if (indexPath.row == 1) {
        VC_NewCenter *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_NewCenter"];
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:VC animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    if (indexPath.row == 2) {
        VC_Guide *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Guide"];
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:VC animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    
    if (indexPath.row == 3) {
        VC_ScanFamily *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_ScanFamily"];
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:VC animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_RightSetCenter *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell_RightSetCenter"];
    [cell setImage:array_DataImg[indexPath.row] withTitle:array_DataTitle[indexPath.row]];
    if (indexPath.row ==4) {
        cell.label_Right.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.label_Right.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - ====================CustomAlertView====================
- (void)clickAlertViewSureBtn:(UIView *)alertView withInputString:(NSString *)inputStr
{
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_Login *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Login"];
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:VC];
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav presentViewController:leftNvaVC animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"push_VC_AcountManager"]) {
        [(VC_AcountManager *)segue.destinationViewController setDict_Infor:dict_Infor];
    }
}


@end
