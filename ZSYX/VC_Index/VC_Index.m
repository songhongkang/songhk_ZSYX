//
//  VC_Index.m
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_Index.h"
#import "VC_Painting.h"


@interface VC_Index ()
{
    UIAlertController *editNameAlc;
    UIAlertAction *submitAction;
    UIAlertAction *cancelAction;
    /// 首页的数据
    NSArray *array_Index;
    /// 顶部的数组
    NSMutableArray *array_menuTitles;
    /// 选择的是那个设备
    NSInteger integer_Num;
    /// 当前是否是主控设备
    BOOL isMainCtr;
    /// 当前账户是绑定设备
    BOOL isBandingEquipment;
}
@end

@implementation VC_Index

#pragma mark - ====================helper====================

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**
     *  加载控制器的时候设置打开抽屉模式  (因为在后面会关闭)
     */
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    [self.button_Rigth sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].user.headImg] forState:UIControlStateNormal placeholderImage:Picture_Default];
    self.button_Rigth.layer.cornerRadius=15;//裁成圆角
    self.button_Rigth.layer.masksToBounds=YES;//隐藏裁剪掉的部分

}

- (void)initData
{
    array_menuTitles = [NSMutableArray array];
    integer_Num = 0;
    isMainCtr = NO;
}

- (void)initLayout
{
    RegisterCollectionHeaderView(self.CollectionView_List, Cell_Index, @"Reusable")
    RegisterCollectionFooterView(self.CollectionView_List,View_IndexRear , @"Footer")
    HK_WeakSelf;
    self.CollectionView_List.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.CollectionView_List.mj_header beginRefreshing];
        [weakSelf fetch_index_Information];
    }];
    
    [self fetch_index_Information];

}

- (void)showEditAlertVC:(NSInteger )row
{
    editNameAlc = [UIAlertController alertControllerWithTitle:nil message:CENTER_EDITNAME preferredStyle:UIAlertControllerStyleAlert];
    submitAction = [UIAlertAction actionWithTitle:CENTER_ALERTSUBMIT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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

- (void)refreshUI:(NSString *)str
{
    [self.button_Top setTitle:str forState:UIControlStateNormal];
}

- (void)refreshLeftButtonIstate:(BOOL )isMainCtr1
{
    if (isMainCtr1) {
        [self.button_Left setImage:[UIImage imageNamed:@"iconfont-shezhi"]];
        [self.button_Left setTitle:nil];
    }else{
        [self.button_Left setTitle:@"   解绑"];
        [self.button_Left setImage:nil];
    }
}

#pragma mark - ====================Networking====================

- (void)fetch_index_Information
{
    [MBProgressHUD showMessage:HTTPLOADING];
    [HTTP_DataPreview fetch_index_Information:[Singleton shareInstance].user.token withSucceed:^(NSDictionary *returnDic) {
        array_Index = [NSMutableArray array];
        array_menuTitles = [NSMutableArray array];
        [MBProgressHUD hideHUD];
        [self.CollectionView_List.mj_header endRefreshing];
        if ([returnDic[@"code"] integerValue] == SUCCESS_CODE) {
            [MBProgressHUD showSuccess:returnDic[@"msg"]];
            array_Index = [MD_Index mj_objectArrayWithKeyValuesArray:returnDic[@"result"]];
            // 1. 归档 存储
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:returnDic[@"result"]];
            // 2. 存储
            [[NSUserDefaults standardUserDefaults] setValue:data forKey:index_Data];
            for (MD_Index *model in array_Index) {
                [array_menuTitles addObject:model.equipName];
            }
            if (!(array_Index.count == 0)) {
                for (NSInteger i = 0; i < array_Index.count ; i ++) {
                    MD_Index *model1 = array_Index[i];
                    if ([model1.type integerValue] == 1) {
                        [kUserDefaults setObject:model1.ID forKey:@"equipID"];
                        [kUserDefaults setObject:model1.equipName forKey:@"equipName"];
                    }
                }
                MD_Index *model1 = array_Index[0];
                [self refreshUI:model1.equipName];
                if ([model1.type integerValue] ==1)
                    isMainCtr = YES;
                else isMainCtr = NO;
            }
            integer_Num = 0;

            [self refreshLeftButtonIstate:isMainCtr];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
        if (array_Index.count != 0) {
            self.CollectionView_List.hidden = NO;
            self.view_NoEquipment.hidden = YES;
            [self.CollectionView_List reloadData];
            isBandingEquipment = YES;
     
        }else{ //没有设备绑定
            self.CollectionView_List.hidden = YES;
            self.view_NoEquipment.hidden = NO;
            [self.button_Left setImage:nil];
            [self.button_Left setTitle:nil];
            isBandingEquipment = NO;
            [self refreshUI:@"没有设备"];
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
            [self fetch_index_Information];
        }else{
            [MBProgressHUD showError:returnDic[@"msg"]];
        }
    } failed:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:HTTPLOADFAILD];
    }];
}

#pragma mark - ====================UICollectionViewDataSource====================

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (array_Index.count == 0) {
        return 0;
    }else{
        MD_Index *model = array_Index[integer_Num];
        return model.switchs.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell_IndexCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_IndexCollection" forIndexPath:indexPath];
    cell.button_ResizeName.tag =  100 + indexPath.row;
    MD_Index *model1 = array_Index[integer_Num];
    cell.model = model1.switchs[indexPath.row];
    [cell.button_ResizeName addTarget:self action:@selector(buttonCollection:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MD_Index *model1 = array_Index[integer_Num];
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        self.header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Reusable" forIndexPath:indexPath];
        reusableView = self.header;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        self.footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        self.footer.array_X = model1.equipDatas;
        self.footer.model= array_Index[integer_Num];
        
        self.footer.usedBlock = ^ {
            VC_Painting *paint = [[VC_Painting alloc] init];
            paint.type = GraphType_BarChart;
            [weakSelf.navigationController pushViewController:paint animated:YES];
        };
        
        self.footer.otherBlock = ^ {
            VC_Painting *paint = [[VC_Painting alloc] init];
            paint.type = GraphType_LineChart;
            [weakSelf.navigationController pushViewController:paint animated:YES];
        };
        reusableView = self.footer;
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%ld个section，第%ld个cell被点击了",(long)indexPath.section,(long)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH  / 2, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 700);
}

#pragma mark - ====================BtnClick====================

- (IBAction)btnTopClick:(id)sender
{
    UIButton *showBtn = sender;
    PopoverView *popoverView = [PopoverView new];
    popoverView.menuTitles   = array_menuTitles;
    HK_WeakSelf;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        [weakSelf.button_Top setTitle:array_menuTitles[index] forState:UIControlStateNormal];
        integer_Num = index;
        MD_Index *model = array_Index[index];
        if ([model.type integerValue] == 1) {
            [self refreshLeftButtonIstate:YES];
            isMainCtr = YES;
        }else{
            [self refreshLeftButtonIstate:NO];
            isMainCtr = NO;
        }
        [weakSelf.CollectionView_List reloadData];
    }];
}

- (IBAction)btnTopTapClick:(UIGestureRecognizer *)sender
{
    if (!isBandingEquipment) {
        return;
    }
    UIView *showBtn = sender.view;
    PopoverView *popoverView = [PopoverView new];
    popoverView.menuTitles   = array_menuTitles;
    HK_WeakSelf;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        [weakSelf.button_Top setTitle:array_menuTitles[index] forState:UIControlStateNormal];
        integer_Num = index;
        MD_Index *model = array_Index[index];
        if ([model.type integerValue] == 1) {
            [self refreshLeftButtonIstate:YES];
            isMainCtr = YES;
        }else{
            [self refreshLeftButtonIstate:NO];
            isMainCtr = NO;
        }
        [weakSelf.CollectionView_List reloadData];
    }];
}

- (IBAction)btnLeftClick:(id)sender
{
    if (!isBandingEquipment) {
        return;
    }
    /// 点击左侧按钮，保存下当前选中的第几个设备
    [kUserDefaults setObject:[NSString stringWithFormat:@"%ld",integer_Num] forKey:index_SelectNum_Equipment];
    if (isMainCtr) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else{
        MD_Index *model = array_Index[integer_Num];
        [self fetch_Ctrl_Device_Unbind:model.ID];
    }
}

- (IBAction)btnRightClick:(id)sender
{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)buttonCollection:(UIButton *)sender
{
    [self showEditAlertVC:sender.tag - 100];
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
