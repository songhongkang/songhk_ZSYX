//
//  VC_LineConfiguration.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_LineConfiguration.h"

@interface VC_LineConfiguration ()
{
    /** alertView中textfield传过来的值 */
    NSString *str;
    ///collectionView dataSource
    NSMutableArray *array_DataSource;
    ///collectionView MainCtrdataSource
    NSMutableArray *array_MainCtrDataSource;
    /// 提示框
    UIAlertController *editNameAlc;
    /// 提交Action
    UIAlertAction *submitAction;
    ///取消Cancle
    UIAlertAction *cancelAction;
    /// 传JSON  array
    NSMutableArray *array_JsonArray;
    /// 设备编号
    NSString *string_equipNo;
}


@end

@implementation VC_LineConfiguration

#pragma mark - ====================helper====================

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}


- (void)initData
{
    array_DataSource = [NSMutableArray array];
    array_MainCtrDataSource = [NSMutableArray array];
    array_JsonArray = [NSMutableArray array];
}

- (void)initLayout
{
    RegisterCollectionHeaderView(self.CollectionView_List, View_LineConfiguration, @"header")
    // 4. 反归档
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:index_Data];
    array_DataSource = [MD_Index mj_objectArrayWithKeyValuesArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    /// 获取首页选择的第几个设备，在首页保存在沙河了
    MD_Index *model = array_DataSource[[[kUserDefaults objectForKey:index_SelectNum_Equipment] integerValue] ];
    string_equipNo = model.equipNo;
    [array_MainCtrDataSource setArray:model.switchs];

//    NSLog([kUserDefaults objectForKey:index_SelectNum_Equipment],nil)
//    NSLog(model.ID,nil)
}
- (void)showEditAlertVC:(NSInteger )row
{
    HK_WeakSelf;
    editNameAlc = [UIAlertController alertControllerWithTitle:nil message:CENTER_EDITNAME preferredStyle:UIAlertControllerStyleAlert];
    submitAction = [UIAlertAction actionWithTitle:CENTER_ALERTSUBMIT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MD_Switchs *model = array_MainCtrDataSource[row];
        model.switchName = [editNameAlc.textFields firstObject].text;
       [array_MainCtrDataSource replaceObjectAtIndex:row withObject:model];
        [weakSelf.CollectionView_List reloadData];
    }];
    
    cancelAction = [UIAlertAction actionWithTitle:CENTER_ALERTCANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [editNameAlc addAction:submitAction];
    [editNameAlc addAction: cancelAction];
    [editNameAlc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [self.navigationController presentViewController:editNameAlc animated:YES completion:nil];
}

#pragma mark - ====================Fetch====================

- (void)fetch_change_CircuitSetting:(NSString *)equipNo withswitchs:(NSArray *)switchs withCurrent:(NSString *)Current withratedPower:(NSString *)ratedPower
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_change_CircuitSetting:[Singleton shareInstance].user.token withequipNo:equipNo withratedCurrent:Current withratedPower:ratedPower withswitchs:switchs withSucceed:^(NSDictionary *returnDic) {
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


#pragma mark - ====================CollectionDelegate====================

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return array_MainCtrDataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        self.header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView = self.header;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_IndexCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_IndexCollection" forIndexPath:indexPath];
    cell.button_ResizeName.tag =  100 + indexPath.item;
    cell.model = array_MainCtrDataSource[indexPath.item];
    [cell.button_ResizeName addTarget:self action:@selector(buttonCollection:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH / 2 , 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 44);
}
#pragma mark - ====================点击事件====================

- (IBAction)change:(UIButton *)sender {
//    NSString *message = @"入户额定功率";
//    if (sender.tag == 11) {
//        message = @"入户额定电流";
//    }
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
//    __weak typeof(alert) weakAlert = alert;
//    UIAlertAction *edit = [UIAlertAction actionWithTitle:CENTER_ALERTSUBMIT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if (sender.tag == 10) {
//            [_btn_Power setTitle:[NSString stringWithFormat:@"%@KW",weakAlert.textFields[0].text] forState:UIControlStateNormal];
//        }else {
//            [_btn_Electricity setTitle:[NSString stringWithFormat:@"%@A",weakAlert.textFields[0].text] forState:UIControlStateNormal];
//        }
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CENTER_ALERTCANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        return ;
//    }];
//    [alert addAction:edit];
//    [alert addAction: cancel];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        UILabel *unitLabel = [[UILabel alloc] init];
//        unitLabel.frame = CGRectMake(0, 0, 25, 20);
//        NSString *placehodler = @"kw";
//        if (sender.tag == 11) {
//            placehodler = @"A";
//            unitLabel.frame = CGRectMake(0, 0, 12, 20);
//        }
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:placehodler];
//        [attrStr addAttribute:NSForegroundColorAttributeName
//                            value:[UIColor greenColor]
//                            range:NSMakeRange(0,placehodler.length)];
//        unitLabel.attributedText = attrStr;
//        textField.rightView = unitLabel;
//        textField.rightViewMode = UITextFieldViewModeAlways;
//        if (sender.tag == 10) {
//            textField.text = [sender.currentTitle substringToIndex:sender.currentTitle.length - 2];
//        } else {
//            textField.text = [sender.currentTitle substringToIndex:sender.currentTitle.length - 1];
//        }
//    }];
//    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
    if (sender.tag == 10) {
        HKAlertView *hkAlertView = [[HKAlertView alloc] initWithTitle:@"输入额定功率" withPlaceHoldTextField:[_btn_Power.currentTitle substringToIndex:_btn_Power.currentTitle.length - 2] sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:YES withFinalyProperty:@"KW"];
        
        hkAlertView.delegate  = self;
        hkAlertView.tag = 100;
        [hkAlertView showHKAlertView];
        
    }else {
        HKAlertView *hkAlertView = [[HKAlertView alloc] initWithTitle:@"输入额定电流" withPlaceHoldTextField:[_btn_Electricity.currentTitle substringToIndex:_btn_Electricity.currentTitle.length - 1] sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:YES withFinalyProperty:@"A"];
        hkAlertView.delegate  = self;
        hkAlertView.tag = 200;
        [hkAlertView showHKAlertView];
    }
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSMutableArray *array = [NSMutableArray array];
    
    double electricity = [[_btn_Electricity.currentTitle substringToIndex:_btn_Electricity.currentTitle.length - 1] doubleValue];
    double power = [[_btn_Power.currentTitle substringToIndex:_btn_Power.currentTitle.length - 2] doubleValue];
    for (MD_Switchs *model in array_MainCtrDataSource) {
        MD_SwitchsNet *model_Switch =  [[MD_SwitchsNet alloc] init];
        model_Switch.switchNo = model.switchNo;
        model_Switch.name = model.switchName;
        [array addObject:model_Switch];
    }
    NSString *string_electricity = [NSString stringWithFormat:@"%lf",electricity];
    NSString *string_power = [NSString stringWithFormat:@"%lf",power];
    array_JsonArray = [MD_Switchs mj_keyValuesArrayWithObjectArray:array];
    [self fetch_change_CircuitSetting:string_equipNo withswitchs:array_JsonArray withCurrent:string_electricity withratedPower:string_power];
}

- (void)buttonCollection:(UIButton *)sender
{
    [self showEditAlertVC:sender.tag - 100];
    MD_Switchs *model = array_MainCtrDataSource[sender.tag - 100];
    
//    model.switchName = [editNameAlc.textFields firstObject].text;
//    [array_MainCtrDataSource replaceObjectAtIndex:row withObject:model];
//    [weakSelf.CollectionView_List reloadData];
    
    HKAlertView *hkAlertView = [[HKAlertView alloc] initWithTitle:@"修改开关名称" withPlaceHoldTextField:model.switchName sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:YES withFinalyProperty:nil];
//    hkAlertView.delegate  = self;
//    hkAlertView.tag = 100;
    HK_WeakSelf;
    hkAlertView.sureTypeBlock = ^(NSString *inputString){
        model.switchName = inputString;
    [array_MainCtrDataSource replaceObjectAtIndex:sender.tag - 100 withObject:model];
        [weakSelf.CollectionView_List reloadData];
    };
    [hkAlertView showHKAlertView];
    
}

#pragma mark - ====================HKAlertViewDelegate====================
    
- (void)clickAlertViewSureBtn:(UIView *)alertView withInputString:(NSString *)inputStr
{
    if (alertView.tag == 100)
        [_btn_Power setTitle:[NSString stringWithFormat:@"%@KW",inputStr] forState:UIControlStateNormal];
    else
        [_btn_Electricity setTitle:[NSString stringWithFormat:@"%@A",inputStr] forState:UIControlStateNormal];
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
