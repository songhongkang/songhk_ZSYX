//
//  VC_TimeSetting.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_TimeSetting.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetPickerCustomPickerDelegate.h"
#import "ActionSheetDatePicker.h"
#import "NSDate+TCUtils.h"
#import "ActionSheetCustomPicker.h"
#import "MD_TimeSetupInfor.h"

@interface VC_TimeSetting ()
{
    /** 数据模型 */
    MD_TimeSetupInfor *timeSetupInfor;
    /** 设备是否登录 */
    BOOL isLoginDevice;
    /// 首页数据
    NSArray *array_DataSource;
    /// 设备ID
    NSString *string_equipID;
    /// 时区的数据源
    NSArray *array_TimeZone;
    /// 时区的ID
    NSString *string_withtimeZoneId;
    /// 24小时制的时间数据
    NSArray *array_TwoFourHours;
    
    /// 24小时制的左边的数据
    NSString *string_1;
    /// 24小时制的右边的数据
    NSString *string_2;
}

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDate *selectedTime;
/** 省份 */
@property (nonatomic,strong) NSString *province;


@end

@implementation VC_TimeSetting

#pragma mark - ====================helper====================

- (void)initData
{
    self.selectedDate = [NSDate date];
    self.selectedTime = [NSDate date];
    string_withtimeZoneId = @"";
    isLoginDevice = YES;
}

- (void)initLayout
{
    // 4. 反归档
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:index_Data];
    array_DataSource = [MD_Index mj_objectArrayWithKeyValuesArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    /// 获取首页选择的第几个设备，在首页保存在沙河了
    MD_Index *model = array_DataSource[[[kUserDefaults objectForKey:index_SelectNum_Equipment] integerValue] ];
    string_equipID = model.ID;
    [self fetch_TimeSetting_information];
}

- (void)fetch_TimeSetting_information {
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Query_TimeSetting:[Singleton shareInstance].user.token ithEquipId:string_equipID withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        timeSetupInfor = [MD_TimeSetupInfor mj_objectWithKeyValues:returnDic[@"result"]];
        [MBProgressHUD showSuccess:returnDic[@"msg"]];
        if ([returnDic[@"code"] integerValue] == 40004) {
            isLoginDevice = NO;
        }
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshUI];
            });
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void) refreshUI {
    [_btn_CityName setTitle:timeSetupInfor.cityName forState:UIControlStateNormal];
//    [_btn_Time setTitle:timeSetupInfor.timeZone forState:UIControlStateNormal];
    [_btn_date setTitle:timeSetupInfor.nowDate forState:UIControlStateNormal];
    [_btn_Time setTitle:timeSetupInfor.nowTime forState:UIControlStateNormal];
    [_btn_Timezone setTitle:timeSetupInfor.timeZoneName forState:UIControlStateNormal];
    if (timeSetupInfor.timeZoneId) {
        string_withtimeZoneId  = timeSetupInfor.timeZoneId;
    }
    _switch_Auto.on = [timeSetupInfor.isAutoSetup isEqualToString:@"1"] ? YES : NO;
    _switch_TwentyFour.on = [timeSetupInfor.isTwentyFour isEqualToString:@"1"] ? YES : NO;
    
    [self setHiddenView:_switch_Auto.on];
    _province = timeSetupInfor.provinceName;
}

- (void)setHiddenView:(BOOL)isShow
{
    self.view_Hide.hidden = isShow;
}

#pragma mark - ====================点击事件====================

- (IBAction)setAuto:(UISwitch *)sender {
    if (sender == _switch_Auto) {
        if (sender.on) {
            self.view_Hide.hidden = NO;
        } else {
            self.view_Hide.hidden = YES;
        }
    }
    sender.on = !sender.on;
}

- (IBAction)selectCity:(UIButton *)sender {
    ActionSheetPickerCustomPickerDelegate *delg = [[ActionSheetPickerCustomPickerDelegate alloc] init];
    
    delg.callback = ^(NSString *province, NSString *cityName) {
        _province = province;
        [sender setTitle:cityName forState:UIControlStateNormal];
    };
    
    NSNumber *yass1 = @5;
    NSNumber *yass2 = @0;
    NSArray *initialSelections = @[yass1, yass2];
    [ActionSheetCustomPicker showPickerWithTitle:@"选择城市" delegate:delg showCancelButton:YES origin:sender
                               initialSelections:initialSelections];
}

- (IBAction)selectTimeZone:(UIButton *)sender {
    
    NSURL *xmlFilePath = [[NSBundle mainBundle] URLForResource:@"timezones.xml" withExtension:nil];
    NSData *xmlData = [NSData dataWithContentsOfURL:xmlFilePath options:NSDataReadingUncached error:NULL];
    array_TimeZone = [MD_Timezones mj_objectArrayWithKeyValuesArray:[WFXMLParser XMLObjectWithData:xmlData]];
    NSMutableArray *array_Zone = [NSMutableArray array];
    for (MD_Timezones *model in array_TimeZone) {
        [array_Zone addObject:model.name];
    }
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"选择时区" rows:array_Zone initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"selectedIndex = %li --- %@", (long)selectedIndex,selectedValue);
        MD_Timezones *model = array_TimeZone[selectedIndex];
        string_withtimeZoneId = model.ID;
        [sender setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
    } origin: sender];
    [picker showActionSheetPicker];
}

- (IBAction)selectDate:(UIButton *)sender {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2000];
    NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
    NSDate *maxDate = [NSDate date];
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"日期" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate
                                                               target:self action:@selector(dateWasSelected:element:) origin:sender];
    
    [(ActionSheetDatePicker *) self.actionSheetPicker setMinimumDate:minDate];
    [(ActionSheetDatePicker *) self.actionSheetPicker setMaximumDate:maxDate];
    
    [self.actionSheetPicker addCustomButtonWithTitle:@"今天" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"昨天" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSCalendarUnitDay amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self.selectedDate];
    [element setTitle:strDate forState:UIControlStateNormal];
}

- (IBAction)selectTime:(UIButton *)sender {
    if (_switch_TwentyFour.on) {
        array_TwoFourHours = @[@[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"],
                               @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"]];
        // 获取系统当前时间
        NSDate * date = [NSDate date];
        NSTimeInterval sec = [date timeIntervalSinceNow];
        NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
        
        //设置时间输出格式：
        NSDateFormatter * df = [[NSDateFormatter alloc] init ];
        [df setDateFormat:@"HH:mm"];
        NSString * na = [df stringFromDate:currentDate];
        NSArray *array = [na componentsSeparatedByString:@":"];
        
        string_1 = array[0];
        string_2 = array[1];
        
        [ActionSheetCustomPicker showPickerWithTitle:@"时间" delegate:self showCancelButton:YES origin:self.view initialSelections:array];
    } else {
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
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_switch_TwentyFour.on) {
        [dateFormatter setDateFormat:@"HH:mm"];
    } else {
        [dateFormatter setDateFormat:@"hh:mm a"];
    }
    [element setTitle:[dateFormatter stringFromDate:selectedTime] forState:UIControlStateNormal];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    // 如果设备没有登陆,点击保存 其中省份无法获取为nil 因此 崩溃.
    if (!isLoginDevice) {
        [MBProgressHUD showError:@"请登录设备"];
        return ;
    }
    NSString *twentyFour = @"1";
    if (!_switch_TwentyFour.on) {
        twentyFour = @"0";
    }
    NSString *autoSetting = @"1";
    if (!_switch_Auto.on) {
        autoSetting = @"0";
    }
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Change_TimeSetting:[Singleton shareInstance].user.token withEquipId:string_equipID withProvinceName:_province withCityName:_btn_CityName.currentTitle withIsTwentyFour:twentyFour withIsAutoSetup:autoSetting withTimeZone:_btn_Timezone.currentTitle withNowDate:_btn_date.currentTitle withNowTime:_btn_Time.currentTitle withtimeZoneId:string_withtimeZoneId  withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================ActionSheetCustomPicker Delegate====================

- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView {
    pickerView.delegate = self;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    [_btn_Time setTitle:[NSString stringWithFormat:@"%@:%@",string_1,string_2] forState:UIControlStateNormal];
}

- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    
}

#pragma mark - PickView Delegete

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [array_TwoFourHours[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return array_TwoFourHours[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%ld - %ld",component, row);

    if (component == 0) {
        string_1 = array_TwoFourHours[0][row];
    }
    if (component ==1) {
        string_2 = array_TwoFourHours[1][row];
    }
//        [_btn_Time setTitle:array_TwoFourHours[component][row] forState:UIControlStateNormal];
    
    [_btn_Time setTitle:[NSString stringWithFormat:@"%@:%@",string_1,string_2] forState:UIControlStateNormal];
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
