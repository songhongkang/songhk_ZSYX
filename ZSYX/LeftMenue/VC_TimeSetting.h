//
//  VC_TimeSetting.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 时间设置


#import "VC_Base.h"
#import "MD_Index.h"
#import "WFXMLParser.h"
#import "MD_Timezones.h"
#import "ActionSheetPicker.h"

@interface VC_TimeSetting : VC_Base <ActionSheetCustomPickerDelegate>

@property (weak, nonatomic) IBOutlet UIView *view_Hide;

@property (weak, nonatomic) IBOutlet UIButton *btn_CityName;
@property (weak, nonatomic) IBOutlet UIButton *btn_Timezone;

@property (weak, nonatomic) IBOutlet UIButton *btn_date;
@property (weak, nonatomic) IBOutlet UIButton *btn_Time;

@property (weak, nonatomic) IBOutlet UISwitch *switch_TwentyFour;
@property (weak, nonatomic) IBOutlet UISwitch *switch_Auto;


@end
