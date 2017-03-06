//
//  VC_AreaTime.m
//  ZSYX
//
//  Created by cnmobi on 16/12/2.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_AreaTime.h"
#import "ActionSheetDatePicker.h"
#import "VC_ScreenSetting.h"

@interface VC_AreaTime ()

@property (nonatomic, strong) NSDate *selectedTime;
@end

@implementation VC_AreaTime

#pragma mark - ====================helper====================

- (void)initData
{
    self.title = @"屏幕点亮时间段";
    self.selectedTime = [NSDate date];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor greenColor]];
    self.switch_Open.on = [self.screenInfor.isOpenLight integerValue] == 1 ? YES :NO;
//    NSLog(self.screenInfor.ID,nil)
    self.view_Hide.hidden = !self.switch_Open.on;
    if (self.switch_Open.on) {
        [self.btn_StartTime setTitle:self.screenInfor.endLightTime forState:UIControlStateNormal];
        [self.btn_StartTime setTitle:self.screenInfor.startLightTime forState:UIControlStateNormal];
    }
}

- (void)initLayout
{
    
    
}

#pragma mark ========== tabbarItem ===========
/*
 * 点击保存按钮 触发的事件
 */
- (void)save {
    if (self.callBack) {
        self.callBack(_switch_Open.on,_btn_StartTime.currentTitle,_btn_EndTime.currentTitle);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ========== btn click ===========
- (IBAction)changeswitch:(UISwitch *)sender {
    
    self.view_Hide.hidden = !sender.on;
}

- (IBAction)selectTime:(UIButton *)sender {
    
    NSInteger minuteInterval = 1;
    //clamp date
    NSInteger referenceTimeInterval = (NSInteger)[self.selectedTime timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceTimeInterval % (minuteInterval *60);
    NSInteger timeRoundedTo5Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>((minuteInterval*60)/2)) {/// round up
        timeRoundedTo5Minutes = referenceTimeInterval +((minuteInterval*60)-remainingSeconds);
    }
    self.selectedTime = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo5Minutes];
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"时间" datePickerMode:UIDatePickerModeTime selectedDate:self.selectedTime target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = minuteInterval;
    [datePicker showActionSheetPicker];
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(UIButton *)element {
    NSLog(@"tag===============%ld",element.tag);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    if (element.tag == 100) element = _btn_StartTime;
    else element = _btn_EndTime;
    
    [element setTitle:[dateFormatter stringFromDate:selectedTime] forState:UIControlStateNormal];
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
