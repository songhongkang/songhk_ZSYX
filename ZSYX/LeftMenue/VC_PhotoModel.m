//
//  VC_PhotoModel.m
//  ZSYX
//
//  Created by cnmobi on 16/11/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_PhotoModel.h"
#import "MD_PhotoModel.h"

@interface VC_PhotoModel ()

{
    /** 模型数据 */
    MD_PhotoModel *photoModel;
    /** 上次选中按钮 */
    UIButton *lastBtn;
    /// 获取首页数据
    NSArray *array_DataSource;
    /// 设备ID
    NSString *string_equipID;
    /// 相框模式
    NSInteger integer_Model;
}

@end

@implementation VC_PhotoModel


#pragma mark - ====================helper====================

- (void)initData
{
}

- (void)initLayout
{
    // 4. 反归档
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:index_Data];
    array_DataSource = [MD_Index mj_objectArrayWithKeyValuesArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    /// 获取首页选择的第几个设备，在首页保存在沙河了
    MD_Index *model = array_DataSource[[[kUserDefaults objectForKey:index_SelectNum_Equipment] integerValue] ];
    string_equipID = model.ID;
    [self fetch_PhotoInformation];
    if (iPhone4)self.layouotConstraint_Height.constant = 667;
        else self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

#pragma mark - ====================Networking====================
/*
 * 请求数据
 */
- (void) fetch_PhotoInformation {
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Query_PhotoFrameSetting:[Singleton shareInstance].user.token withEquipId:string_equipID withSucceed:^(NSDictionary *returnDic) {
        photoModel = [MD_PhotoModel mj_objectWithKeyValues:returnDic[@"result"]];
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == 1) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
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

- (void) fetch_Change_PhotoFrmeSetting
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_SettingInfor fetch_Change_PhotoFrmeSetting:[Singleton shareInstance].user.token withEquipId:string_equipID withModel:[NSString stringWithFormat:@"%d",(int)integer_Model] withPhoneExchangeTime:[_label_changPhoto.text substringWithRange:NSMakeRange(0, _label_changPhoto.text.length - 1) ]withModelLastTime:[_label_continueTime.text  substringWithRange:NSMakeRange(0, _label_continueTime.text.length-1)] withSucceed:^(NSDictionary *returnDic) {
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

- (void)refreshUI {
    [self refreshLabelWithModelType:[photoModel.model integerValue]];
    integer_Model = [photoModel.model integerValue];

    self.label_changPhoto.text = [NSString stringWithFormat:@"%@s",photoModel.phoneExchangeTime];
    self.label_continueTime.text = [NSString stringWithFormat:@"%@h",photoModel.modelLastTime];
}

- (void) refreshLabelWithModelType:(NSInteger)type {
    NSString *model = @"非相框模式";
    /// 目前就是为了解决 img的显示和隐藏
    UIImageView *img1 =   [self.view viewWithTag:200];
    UIImageView *img2 =   [self.view viewWithTag:201];
    UIImageView *img3 =   [self.view viewWithTag:202];
    
    switch (type) {
        case 0:
            model = @"非相框模式";
            img1.hidden = NO;
            img2.hidden = YES;
            img3.hidden = YES;
            break;
        case 1:
            model = @"半屏相框模式";
            img2.hidden = NO;
            img1.hidden = YES;
            img3.hidden = YES;
            break;
        default:
            model = @"全屏相框模式";
            img2.hidden = YES;
            img1.hidden = YES;
            img3.hidden = NO;
            break;
    }
    self.label_CurrentModel.text = model;
}

#pragma mark - ====================弹出pickerView====================

- (IBAction)changePhoto:(UIButton *)sender {
    NSArray *times = @[@"5s",@"10s",@"20s",@"30s",@"40s",@"50s"];
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"照片切换时间"  rows:times initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        NSLog(@"selectedIndex = %li --- %@", (long)selectedIndex,selectedValue);
        _label_changPhoto.text = selectedValue;
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        NSLog(@"picker = %@", stringPicker);
    } origin: (UIView*)sender ];
    [picker showActionSheetPicker];
}

- (IBAction)photoContinueTime:(UIButton *)sender {
    
    NSArray *times = @[@"1h",@"2h",@"3h",@"4h",@"5h",@"6h"];
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"相框模式持续时间"  rows:times initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        _label_continueTime.text = selectedValue;
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        NSLog(@"picker = %@", stringPicker);
    } origin: (UIView*)sender ];
    [picker showActionSheetPicker];
}

#pragma mark - ====================点击事件====================
- (IBAction)changePhotoModel:(UIButton *)sender {
    sender.selected = !sender.selected;
    lastBtn.selected = NO;
    lastBtn = sender;
    NSInteger type = sender.tag - 100;
    integer_Model = type;
    
    
//    NSLog([NSString stringWithFormat:@"%ld",integer_Model],nil)
    
    [self refreshLabelWithModelType:type];
    
    /// 目前就是为了解决 img的显示和隐藏
    UIImageView *img1 =   [self.view viewWithTag:200];
    UIImageView *img2 =   [self.view viewWithTag:201];
    UIImageView *img3 =   [self.view viewWithTag:202];
    
    if (sender.tag - 100 == 0) { //第一个
            img1.hidden = NO;
            img2.hidden = YES;
            img3.hidden = YES;
    }
    if (sender.tag - 100 == 1) { //第二个
            img2.hidden = NO;
            img1.hidden = YES;
            img3.hidden = YES;
    }
    if (sender.tag - 100 == 2) { //第三个
            img2.hidden = YES;
            img1.hidden = YES;
            img3.hidden = NO;
    }
}

- (IBAction)save:(UIBarButtonItem *)sender {
// fetch_Change_PhotoFrmeSetting
    [self fetch_Change_PhotoFrmeSetting];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
