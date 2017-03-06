//
//  VC_Base.h
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 控制器基类

#import <UIKit/UIKit.h>
#import "MacroDefinition.h"
#import "CALayer+XibConfiguration.h"
#import "NSString+aes.h"
#import "HTTP_DevieInfor.h"
#import "HTTP_Count.h"
#import "HTTP_DataPreview.h"
#import "HTTP_SettingInfor.h"
#import "MBProgressHUD+Tools.h"
#import "Singleton.h"
#import <MJExtension/MJExtension.h>
#import "NotificationMacro.h"
#import "ActionSheetStringPicker.h"


@interface VC_Base : UIViewController

- (void)initData;

- (void)initLayout;
@end
