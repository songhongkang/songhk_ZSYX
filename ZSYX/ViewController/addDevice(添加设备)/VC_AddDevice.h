//
//  VC_AddDevice.h
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 添加设备

#import "VC_Base.h"
#import "VC_ReadyAdd.h"
#import "VC_ConnectInternet.h"
#import "VC_ConfigurationSettings.h"


@interface VC_AddDevice : VC_Base <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end
