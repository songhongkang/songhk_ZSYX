//
//  VC_DeviceBindingInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 设备绑定

#import "VC_Base.h"
#import "Cell_DeviceBindingInfor.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "MD_DeviceBindingInfor.h"
#import "MD_Index.h"
#import "HKAlertView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>


@interface VC_DeviceBindingInfor : VC_Base <UITableViewDelegate, UITableViewDataSource, HKAlertViewDelegate>

/// 设备名字
@property IBOutlet UILabel * label_DeviceName;
/// MainTable
@property IBOutlet UITableView *tableView_List;
@end
