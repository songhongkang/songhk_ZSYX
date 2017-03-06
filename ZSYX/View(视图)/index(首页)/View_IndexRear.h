//
//  View_IndexRear.h
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LewBarChart.h"
#import "MainHeader.h"
#import "PNChart.h"
#import "PNCircleChart.h"
#import "MD_Index.h"
#import "MD_Electric.h"



typedef void (^ClickBarChart)();


@interface View_IndexRear : UICollectionReusableView
/// 柱状图
@property (nonatomic,strong)LewBarChart *barChart;
/// 柱状图的父视图
@property (nonatomic,strong) IBOutlet UIView *view_barChart;
@property (weak, nonatomic) IBOutlet UIView *view_Other;
/// X轴的坐数据
@property (nonatomic, strong) NSArray *array_X;
/// Y轴的坐数据
@property (nonatomic, strong) NSArray *array_Y;
///Line1距离左边的距离
@property IBOutlet NSLayoutConstraint *constraint_Line1Left;
///Line2距离右边的距离
@property IBOutlet NSLayoutConstraint *constraint_Line1Right;
/// 今日用电量
@property IBOutlet UILabel * label_DayUseElectric;
/// 今月用电量
@property IBOutlet UILabel * label_MonthUseElectric;
/// 总功率
@property IBOutlet UILabel * label_ratedPower;
/// 总电流
@property IBOutlet UILabel * label_ratedCurrent;
/// 电池
@property IBOutlet UILabel * label_batteryLevel;
/// 湿度
@property IBOutlet UILabel * label_boxHumidity;
/// 底部总功率 和上面的总功率一样
@property IBOutlet UILabel * label_BottomratedPower;
/// 运行时间（h）
@property IBOutlet UILabel * label_runTime;
/// wifi状态
@property IBOutlet UIButton * button_WifiState;
/// 首页模型
@property(nonatomic, strong)MD_Index *model;
/*
 * 用电量回调的blcok
 */
@property(nonatomic,copy)ClickBarChart usedBlock;

/*
 * 其他回调的blcok
 */
@property(nonatomic,copy)ClickBarChart otherBlock;

@end
