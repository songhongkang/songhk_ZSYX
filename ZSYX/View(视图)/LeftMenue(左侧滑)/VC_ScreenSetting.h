//
//  VC_ScreenSetting.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 屏幕设置


#import "VC_Base.h"
#import "Cell_ScreenSetting.h"
#import "View_ScreenSetting.h"
#import "MD_ScreenGetInfor.h"
#import "MD_Index.h"

@interface VC_ScreenSetting : VC_Base <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 屏幕亮度*/
@property (weak, nonatomic) IBOutlet UILabel *label_ScreenLight;
/** 屏幕亮度滑块*/
@property (weak, nonatomic) IBOutlet UISlider *slider;
/** 屏幕点亮时间段*/
@property (weak, nonatomic) IBOutlet UIButton *btn_StartLight;
/** 自动息屏*/
@property (weak, nonatomic) IBOutlet UIButton *btn_ContinueTime;
/** 屏保*/
@property (weak, nonatomic) IBOutlet UISwitch *switch_Screensaver;
/** 加入屏保时间*/
@property (weak, nonatomic) IBOutlet UIButton *btn_enterTime;
/** CollectionView*/
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview_List;

@end
