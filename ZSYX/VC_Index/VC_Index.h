//
//  VC_Index.h
//  ZSYX
//
//  Created by cnmobi on 16/10/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
/// 首页


#import "VC_Base.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "Cell_Index.h"
#import "View_IndexRear.h"
#import "VC_Login.h"
#import "PopoverView.h"
#import "MD_Index.h"
#import "Cell_IndexCollection.h"
#import <MJRefresh/MJRefresh.h>
#import "MD_Electric.h"

@interface VC_Index : VC_Base <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/// collectionView
@property IBOutlet UICollectionView * CollectionView_List;
/// 头
@property(strong,nonatomic)Cell_Index *header;
/// 尾
@property(strong,nonatomic)View_IndexRear *footer;
/// 顶部
@property IBOutlet UIButton * button_Top;
/// 左边的按钮
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_Left;
/// 右边按钮
@property IBOutlet UIButton * button_Rigth;
/// 没有设备的页面
@property IBOutlet UIView *view_NoEquipment;
@end
