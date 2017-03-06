//
//  VC_AreaTime.h
//  ZSYX
//
//  Created by cnmobi on 16/12/2.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 地区时间设置


#import "VC_Base.h"
#import "MD_ScreenSetupInfor.h"

typedef void (^blcok_callBack)(BOOL, NSString *, NSString *);
@interface VC_AreaTime : VC_Base
/// 时间端的View
@property (strong, nonatomic) IBOutlet UIView *view_Hide;
/// uisiwitch控件
@property (weak, nonatomic) IBOutlet UISwitch *switch_Open;
/// 开始时间的按钮
@property (weak, nonatomic) IBOutlet UIButton *btn_StartTime;
/// 结束时间的按钮
@property (weak, nonatomic) IBOutlet UIButton *btn_EndTime;
/// 返回的Block
@property (copy, nonatomic) blcok_callBack callBack;
///获取当前设置屏保界面的模型
@property (strong, nonatomic) MD_ScreenSetupInfor *screenInfor;

@property NSString *string;

@end
