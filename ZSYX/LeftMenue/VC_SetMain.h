//
//  VC_SetMain.h
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 设置界面

#import "VC_Base.h"
#import "UIViewController+MMDrawerController.h"
#import "Cell_LeftSetMain.h"
#import "VC_DeviceBindingInfor.h"
#import "VC_LineConfiguration.h"
#import "VC_ScreenSetting.h"
#import "VC_TimeSetting.h"
#import "VC_InviteFamily.h"
#import "VC_PhotoModel.h"



@interface VC_SetMain : VC_Base <UITableViewDelegate, UITableViewDataSource>

///tableView List
@property IBOutlet UITableView *tableView_List;
@end
