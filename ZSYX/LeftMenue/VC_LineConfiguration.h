//
//  VC_LineConfiguration.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 线路配置

#import "VC_Base.h"
#import "View_LineConfiguration.h"
#import "Cell_IndexCollection.h"
#import "MD_Index.h"
#import "MD_Switchs.h"
#import "MD_SwitchsNet.h"
#import "HKAlertView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>



@interface VC_LineConfiguration : VC_Base <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HKAlertViewDelegate>

///CollectionViewHeader
@property (nonatomic, strong) View_LineConfiguration *header;
///CollectionView
@property (nonatomic, strong) IBOutlet UICollectionView *CollectionView_List;
/// 入户功率按钮
@property (weak, nonatomic) IBOutlet UIButton *btn_Power;
/// 入户额定电流
@property (weak, nonatomic) IBOutlet UIButton *btn_Electricity;

@end
