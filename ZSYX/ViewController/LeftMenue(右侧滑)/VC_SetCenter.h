//
//  VC_SetCenter.h
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 个人中心

#import "VC_Base.h"
#import "Cell_RightSetCenter.h"
#import "UIScrollView+SpringHeadView.h"
#import "VC_Login.h"
#import "View_PersonalCenter.h"
#import "VC_AcountManager.h"
#import "VC_Add.h"
#import "VC_NewCenter.h"
#import "VC_ScanFamily.h"
#import "VC_Guide.h"
#import "HKAlertView.h"

@interface VC_SetCenter : VC_Base <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, HKAlertViewDelegate>
/// TableView List
@property IBOutlet UITableView *tableView_List;

@end
