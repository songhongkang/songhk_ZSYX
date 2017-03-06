//
//  VC_DeviceBindingInfor.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_DeviceBindingInfor.h"

@interface VC_DeviceBindingInfor ()
{
    /// tableView data Source
    NSArray *array_TableDataSource;
    /// 获取首页接口数据
    NSArray *array_DataSource;
    /// 设备编号
    NSString *string_equipID;
}
@end

@implementation VC_DeviceBindingInfor

#pragma mark - ====================helper====================


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];

}

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
    self.label_DeviceName.text = model.equipName;
    [self fetch_BindEquip_Device_UserList];
}


- (void)showEditAlertVC
{
//    HK_WeakSelf;
    UIAlertController *editNameAlc = [UIAlertController alertControllerWithTitle:nil message:CENTER_EDITNAME preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:CENTER_ALERTSUBMIT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [weakSelf fetch_Update_Device_EquipName];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CENTER_ALERTCANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [editNameAlc addAction:submitAction];
    [editNameAlc addAction: cancelAction];
    [editNameAlc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidEndEditingNotification object:textField];
    }];
    [self.navigationController presentViewController:editNameAlc animated:YES completion:nil];
}

#pragma mark - ====================Networking====================

- (void)fetch_BindEquip_Device_UserList
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_BindEquip_Device_UserList:[Singleton shareInstance].user.token withequipId:string_equipID withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            array_TableDataSource = [MD_DeviceBindingInfor mj_objectArrayWithKeyValuesArray:returnDic[@"result"]];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
        [self.tableView_List reloadData];
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void)fetch_Update_Device_EquipName:(NSString *)astring
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_Update_Device_EquipName:[Singleton shareInstance].user.token withequipId:string_equipID withequipName:self.label_DeviceName.text withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            self.label_DeviceName.text = astring;
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void)fetch_MainCtrl_Device_Unbind:(MD_DeviceBindingInfor *)model
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_MainCtrl_Device_Unbind:[Singleton shareInstance].user.token withequipId:[kUserDefaults objectForKey:@"equipID"] withuserId:model.userId withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            [self fetch_BindEquip_Device_UserList];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

- (void)fetch_Ctrl_Device_Unbind:(NSString *)equipId
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DevieInfor fetch_Ctrl_Device_Unbind:[Singleton shareInstance].user.token withequipId:equipId withSucceed:^(NSDictionary *returnDic) {
        [MBProgressHUD hideHUD];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
//            [self fetch_index_Information];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================Delegate====================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_TableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_DeviceBindingInfor *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell_DeviceBindingInfor"];
    cell.model = array_TableDataSource[indexPath.row];
    cell.button_CancleShare.tag = 100 + indexPath.row;
    [cell.button_CancleShare addTarget:self action:@selector(btnCellRightClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - ====================BtnClick====================
- (void)btnCellRightClick:(UIButton *)sender
{
    MD_DeviceBindingInfor *model = array_TableDataSource[sender.tag - 100];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否取消共享" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction_Ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fetch_MainCtrl_Device_Unbind:model];
    }];
    UIAlertAction *alertAction_Cancle = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction_Ok];
    [alertController addAction:alertAction_Cancle];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)btnReviseDeviceName:(id)sender
{
//    [self showEditAlertVC];
    HKAlertView *hkAlertView = [[HKAlertView alloc] initWithTitle:@"请输入修改内容" withPlaceHoldTextField:self.label_DeviceName.text sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:YES withFinalyProperty:nil];
    hkAlertView.delegate  = self;
    hkAlertView.tag = 100;
    [hkAlertView showHKAlertView];
    
}

- (IBAction)btnDeleteEquipmentClick:(UIButton *)sender
{
    HKAlertView *hkAlertView = [[HKAlertView alloc] initWithTitle:[NSString stringWithFormat:@"删除后将不能配置和查看设备“%@”,是否确认删除设备",self.label_DeviceName.text] withPlaceHoldTextField:nil sureBtn:@"确定" cancleBtn:@"取消" withController:self IsHaveTextFiled:NO withFinalyProperty:nil];
    hkAlertView.delegate  = self;
    hkAlertView.tag = 200;
    [hkAlertView showHKAlertView];
    
}

#pragma mark - ====================HKAlertViewDelegate====================



- (void)clickAlertViewSureBtn:(UIView *)alertView withInputString:(NSString *)inputStrP
{
    if (alertView.tag == 200) [self fetch_Ctrl_Device_Unbind:string_equipID];
    else [self fetch_Update_Device_EquipName:inputStrP];
}

#pragma mark - ===================NotificationSelector====================
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        self.label_DeviceName.text =login.text;
    }
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
