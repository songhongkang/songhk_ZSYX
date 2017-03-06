//
//  VC_ScreenSetting.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_ScreenSetting.h"
#import "Cell_ScreenSetting.h"
#import "View_ScreenSetting.h"
#import "ActionSheetStringPicker.h"
#import "MD_ScreenSetupInfor.h"
#import "VC_AreaTime.h"

@interface VC_ScreenSetting ()
{
    /// collectionView Cell Temp Datasource
    NSMutableArray *array_CollectionSource;
    /// collectionView Cell  Datasource
    NSMutableArray *array_CollectionSource1;
    /// 获取屏保的设置模型
    MD_ScreenSetupInfor *screenInfor;
    /// 获取选中的屏保图片ID
    NSString *ScreensaverImgId;
    /// 获取首页中的所有数据
    NSArray *array_Index;
    /// 这个页面的设备ID
    NSString *string_EquipId;
}

@property (assign,nonatomic) BOOL isOpen;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;

@end

@implementation VC_ScreenSetting

#pragma mark - ====================helper====================

/// 关闭全屏手势
- (BOOL)fd_interactivePopDisabled
{
    return YES;
}

- (void)initData
{
    array_CollectionSource = [NSMutableArray array];
    array_CollectionSource1 = [NSMutableArray array];
}

- (void)initLayout
{
    // 4. 反归档
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:index_Data];
    array_Index = [MD_Index mj_objectArrayWithKeyValuesArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    /// 获取首页选择的第几个设备，在首页保存在沙河了
    MD_Index *model = array_Index[[[kUserDefaults objectForKey:index_SelectNum_Equipment] integerValue] ];
    string_EquipId = model.ID;
    [self fetch_ScreenSetting_Infromation];
    _slider.minimumTrackTintColor = COLOR(0, 227, 109, 1);
    _slider.thumbTintColor = COLOR(0, 227, 109, 1);
}

- (void) refreshUI {
    _slider.value = [screenInfor.screenLight doubleValue] / 100.0;

    [self changeProgress:_slider];
    [_btn_StartLight setTitle:[screenInfor.isOpenLight isEqualToString:@"1"] ? @"开启" : @"未开启" forState:UIControlStateNormal];
    [_btn_ContinueTime setTitle:[self getHistStr:screenInfor.autoCloseLight]  forState:UIControlStateNormal];
    [_btn_enterTime setTitle:[self getHistString:screenInfor.openScreensaverTime] forState:UIControlStateNormal];
    
    _switch_Screensaver.on = [screenInfor.isOpenScreensaver isEqualToString:@"1"] ? YES : NO;
    
}

- (NSString *) getHistStr:(NSString *)str {
    NSString *histStr = @"永不";
    if (![str isEqualToString:@"0"]) {
        histStr = [NSString stringWithFormat:@"%@mins",str];
    }
    return histStr;
}

- (NSString *) getHistString:(NSString *)str {
    NSString *histStr = @"待机";
    if (![str isEqualToString:@"0"]) {
        histStr = [NSString stringWithFormat:@"%@s",str];
    }
    return histStr;
}
#pragma mark - ====================Networking====================
- (void) fetch_ScreenSetting_Infromation
{
    [HTTP_SettingInfor fetch_ScreenSetting:[Singleton shareInstance].user.token withEquipId:string_EquipId withSucceed:^(NSDictionary *returnDic) {
        screenInfor  = [MD_ScreenSetupInfor mj_objectWithKeyValues:returnDic[@"result"]];
        [MBProgressHUD showSuccess:returnDic[@"msg"]];
        [self fetch_Screensaver_Information];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshUI];
            });
        }
    } failed:^{
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}
- (void)fetch_Screensaver_Information
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Screensaver_Information:[Singleton shareInstance].user.token withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            array_CollectionSource1 = [MD_ScreenGetInfor mj_objectArrayWithKeyValuesArray:returnDic[@"result"]];
            for (MD_ScreenGetInfor *model in array_CollectionSource1) {
                if ([model.ID isEqualToString:screenInfor.screensaverImgId])
                    model.isSelect = YES;else model.isSelect = NO;
                [array_CollectionSource addObject:model];
            }
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
        [self.collectionview_List reloadData];
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void) fetch_Change_ScreenSetting:(NSString *)Brightness withOpenLight:(NSString *)OpenLight withStartLightTime:(NSString *)StartLightTime withEndLightTime:(NSString *)EndLightTimew withAutoCloseLight:(NSString *)AutoCloseLight withOpenScreensaverTime:(NSString *)OpenScreensaverTime withScreensaverImgId:(NSString *)ScreensaverImgId1
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Change_ScreenSetting:[Singleton shareInstance].user.token withEquipId:string_EquipId withscreenLight:Brightness withIsOpenLight:OpenLight withStartLightTime:StartLightTime withEndLightTime:EndLightTimew withAutoCloseLight:AutoCloseLight withOpenScreensaverTime:OpenScreensaverTime withScreensaverImgId:ScreensaverImgId1 withisOpenScreensaver:_switch_Screensaver.on ? @"1": @"0" withSucceed:^(NSDictionary *returnDic) {
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

#pragma mark - ====================VCDELEGATE====================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return array_CollectionSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((SCREEN_WIDTH - 6 - 16  ) / 3, 94);
    return CGSizeMake(168, 94);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_ScreenSetting *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_ScreenSetting" forIndexPath:indexPath];
    cell.model = array_CollectionSource[indexPath.item];
    cell.button_Bg.tag = 100 + indexPath.item;
    [cell.button_Bg addTarget:self action:@selector(btnCollectionViewOfButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark - ====================点击事件====================

- (void)btnCollectionViewOfButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    for (int i = 0; i < array_CollectionSource.count; i ++) {
        MD_ScreenGetInfor *model = array_CollectionSource[i];
        model.isSelect = NO;
        if (sender.tag - 100  == i) {
            model.isSelect = YES;
        }
        [array_CollectionSource replaceObjectAtIndex:i withObject:model];
    }
    [self.collectionview_List reloadData];
}

- (IBAction)changeProgress:(UISlider *)sender {
    _label_ScreenLight.transform = CGAffineTransformMakeTranslation(sender.value * (self.view.bounds.size.width - 20 - 30), 0);
    _label_ScreenLight.text = [NSString stringWithFormat:@"%0.f%%",sender.value * 100] ;
}

- (IBAction)btnTimeAreaClick:(UIButton *)sender {
    
    VC_AreaTime *areaVC = [[VC_AreaTime alloc] init];
    areaVC.screenInfor = screenInfor;
     [self.navigationController pushViewController:areaVC animated:YES];
        areaVC.callBack = ^ (BOOL isOpen, NSString *startTime, NSString *endTime) {
            screenInfor.isOpenLight = isOpen ? @"1" : @"0";
            screenInfor.endLightTime = endTime;
            screenInfor.startLightTime = startTime;
        [_btn_StartLight setTitle:isOpen ? @"开启" : @"未开启" forState:UIControlStateNormal];
    };
}

- (IBAction)btnAutoSleepClick:(UIButton *)sender {
    NSArray *times = @[@"永不",@"5mins",@"15mins",@"35mins",@"45mins",@"60mins"];
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"自动息屏" rows:times initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"selectedIndex = %li --- %@", (long)selectedIndex,selectedValue);
        [_btn_ContinueTime setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        NSLog(@"picker = %@", stringPicker);
    } origin: (UIView*)sender ];
    [picker showActionSheetPicker];
}

- (IBAction)switchChangeClick:(UISwitch *)sender {
    NSLog(@"switchChangeClick");
}
- (IBAction)btnEnterClick:(UIButton *)sender {
    NSArray *times = @[@"待机",@"10s",@"20s",@"30s",@"40s",@"50s"];
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"自动息屏" rows:times initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"selectedIndex = %li --- %@", (long)selectedIndex,selectedValue);
        [_btn_enterTime setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        
    } origin: (UIView*)sender ];
    [picker showActionSheetPicker];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSString *openLight = @"1"; // 屏保状态
    if (!_switch_Screensaver.on) {
        openLight = @"0";
    }
    NSString *intervalStr = _btn_ContinueTime.currentTitle;
    if(![intervalStr isEqualToString:@"永不"]) {
        intervalStr = [intervalStr substringWithRange:NSMakeRange(0, intervalStr.length - 4)];
    }else{
        intervalStr = @"0";
    }
    NSString *enterStr = _btn_enterTime.currentTitle; //进入屏保时间
    if(![enterStr isEqualToString:@"待机"]) {
        enterStr = [enterStr substringWithRange:NSMakeRange(0, enterStr.length - 1)];
    }else{
       enterStr = @"0";
    }
    for (MD_ScreenGetInfor *model in array_CollectionSource) {
        if (model.isSelect) {
            ScreensaverImgId = model.ID;
        }
    }
    [self fetch_Change_ScreenSetting:[NSString stringWithFormat:@"%d",(int)(_slider.value * 100)] withOpenLight:screenInfor.isOpenLight withStartLightTime:screenInfor.startLightTime withEndLightTime:screenInfor.endLightTime withAutoCloseLight:intervalStr withOpenScreensaverTime:enterStr withScreensaverImgId:ScreensaverImgId];
}

-(void)dealloc {
    NSLog(@"dealloc");
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
