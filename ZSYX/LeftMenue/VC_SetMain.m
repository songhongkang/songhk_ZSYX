//
//  VC_SetMain.m
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_SetMain.h"

@interface VC_SetMain ()
{
    NSArray *array_DataImg; //图片
    NSArray *array_DataTitle; //文字
}
@end

@implementation VC_SetMain

#pragma mark - ====================helper====================

- (void)initData
{
    array_DataImg = @[@"iconfont_shebeibangding",@"iconfont_xianlusheji",@"iconfont_pingmusheji",@"iconfont_shijianshzhi",@"iconfont_xiangkuangmoshi",@"iconfont_yaoqingjiaren"];
    array_DataTitle = @[@"设备绑定信息",@"线路设置",@"屏幕设置",@"时间设置",@"相框模式设置",@"邀请家人"];
}

- (void)initLayout
{
    self.title = @"设置";
    self.tableView_List.separatorStyle = NO;
}

#pragma mark - ====================Delegate====================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_DeviceBindingInfor *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_DeviceBindingInfor"];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        case 1:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_LineConfiguration *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_LineConfiguration"];
            
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        case 2:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_ScreenSetting *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_ScreenSetting"];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        case 3:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_TimeSetting *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_TimeSetting"];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        case 4:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_PhotoModel *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_PhotoModel"];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        case 5:
        {
            UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            VC_InviteFamily *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_InviteFamily"];
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:VC animated:NO];
        }
            break;
        default:
            break;
    }
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_LeftSetMain *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell_LeftSetMain"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setImage:array_DataImg[indexPath.row] withTitle:array_DataTitle[indexPath.row]];
    return cell;
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
