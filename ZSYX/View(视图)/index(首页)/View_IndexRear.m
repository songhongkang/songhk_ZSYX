//
//  View_IndexRear.m
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "View_IndexRear.h"

@interface View_IndexRear ()
{
    /// 圆形图
    PNCircleChart * circleChart;
    PNCircleChart * circleChart1;
    PNCircleChart * circleChart2;
    PNCircleChart * circleChart3;
    PNCircleChart * circleChart4;
    PNCircleChart * circleChart5;
}
@end

@implementation View_IndexRear

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self makeGestures];
    self.constraint_Line1Left.constant  =  (SCREEN_WIDTH - 20 ) / 3;
    self.constraint_Line1Left.constant  =  (SCREEN_WIDTH - 20 ) / 3;
    [self createCircleChart];
}
- (void)setArray_X:(NSArray *)array_X
{
    for(UIView *view in [self.view_barChart subviews])
    {
        [view removeFromSuperview];
    }
    NSMutableArray *array_XLabel = [NSMutableArray array];
    NSMutableArray *array_YLabel = [NSMutableArray array];
    for (MD_Electric *model in array_X) {
        NSString *string_Time = [model.createDate substringWithRange:NSMakeRange(5, 5)];
        [array_XLabel addObject:[string_Time stringByReplacingOccurrencesOfString:@"-" withString:@"."]];
        if (model.value) {
            [array_YLabel addObject:model.value];
        }else{
            [array_YLabel addObject:@0];
        }
    }
    _barChart = [[LewBarChart alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 150 , 200 - 20  )];
    LewBarChartDataSet *set1 = [[LewBarChartDataSet alloc] initWithYValues:array_YLabel label:@"报名人数"];
    [set1 setBarColor:[UIColor colorWithRed:0.000 green:0.890 blue:0.427 alpha:1.000]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LewBarChartData *data = [[LewBarChartData alloc] initWithDataSets:dataSets];
    data.xLabels = array_XLabel;
    
    data.itemSpace = 6;
    _barChart.data = data;
    _barChart.displayAnimated = YES;
    
    _barChart.chartMargin = UIEdgeInsetsMake(20, 15, 45, 15);
    _barChart.showYAxis = NO;
    _barChart.showNumber = YES;
    _barChart.legendView.alignment = LegendAlignmentHorizontal;
    
    [self.view_barChart addSubview:_barChart];
    [_barChart show];
    
    CGPoint legendCenter = CGPointMake(SCREEN_WIDTH - _barChart.legendView.bounds.size.width/2, -18);
    _barChart.legendView.center = legendCenter;
}


- (void)makeGestures {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_view_barChart addGestureRecognizer:tap];
    UITapGestureRecognizer *otherTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(otherTap:)];
    [_view_Other addGestureRecognizer:otherTap];
}

- (void) tap:(UITapGestureRecognizer *)sendr {
    if (self.usedBlock) {
        self.usedBlock();
    }
}
- (void) otherTap:(UITapGestureRecognizer *)sendr {
    if (self.otherBlock) {
        self.otherBlock();
    }
}

- (void)createCircleChart
{
     circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:RGB(255, 206, 10)];
    circleChart.lineWidth = @4;
    [circleChart strokeChart];
    UIView *view1 = [self viewWithTag:100];
    [view1 addSubview:circleChart];
    
     circleChart1 = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart1.backgroundColor = [UIColor clearColor];
    [circleChart1 setStrokeColor:RGB(255, 96, 10)];
    circleChart1.lineWidth = @4;
    [circleChart1 strokeChart];
    UIView *view2 = [self viewWithTag:101];
    [view2 addSubview:circleChart1];
    
    
     circleChart2 = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart2.backgroundColor = [UIColor clearColor];
    [circleChart2 setStrokeColor:RGB(21, 288, 104)];
    circleChart2.lineWidth = @4;
    [circleChart2 strokeChart];

    UIView *view3 = [self viewWithTag:102];
    [view3 addSubview:circleChart2];

    
     circleChart3 = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart3.backgroundColor = [UIColor clearColor];
    [circleChart3 setStrokeColor:RGB(137, 216, 34)];
    circleChart3.lineWidth = @4;
    [circleChart3 strokeChart];
    UIView *view4 = [self viewWithTag:103];
    [view4 addSubview:circleChart3];
    
    
     circleChart4 = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart4.backgroundColor = [UIColor clearColor];
    [circleChart4 setStrokeColor:RGB(255, 156, 34)];
    circleChart4.lineWidth = @4;
    [circleChart4 strokeChart];
    UIView *view5 = [self viewWithTag:104];
    [view5 addSubview:circleChart4];
    
    circleChart5 = [[PNCircleChart alloc] initWithFrame:CGRectMake(10, 5, 100, SCREEN_WIDTH/3 - 10 - 20) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:YES shadow:YES shadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] displayCountingLabel:NO];
    circleChart5.backgroundColor = [UIColor clearColor];
    [circleChart5 setStrokeColor:RGB(47, 255, 210)];
    circleChart5.lineWidth = @4;
    [circleChart5 strokeChart];
    UIView *view6 = [self viewWithTag:105];
    [view6 addSubview:circleChart5];
}

- (void)setModel:(MD_Index *)model
{
    /// wifi状态
    self.button_WifiState.selected = [model.wifiStatus isEqualToString:@"1"] ? YES : NO;
    /// 运行时间
    self.label_runTime.text = [NSString stringWithFormat:@"%@h",model.runTime];
    /// 总功率
    self.label_BottomratedPower.text = [NSString stringWithFormat:@"%@KW",model.totalPow];
    /// 今日用电量
    self.label_DayUseElectric.text = [NSString stringWithFormat:@"%@/kwh",model.dayUseElectric];
    /// 今月用电量
    self.label_MonthUseElectric.text = [NSString stringWithFormat:@"%@/kwh",model.monthUseElectric];
    /// 总功率
    [circleChart updateChartByCurrent:[NSNumber numberWithInteger:[model.totalPow integerValue]] byTotal:[NSNumber numberWithInteger:[model.ratedCurrent integerValue]]];
    self.label_ratedPower.text = [NSString stringWithFormat:@"%@KW",model.totalPow];
    /// 总电流
    [circleChart1 updateChartByCurrent:[NSNumber numberWithInteger:[model.electricCurrent integerValue]] byTotal:[NSNumber numberWithInteger:[model.ratedCurrent integerValue]]];
    self.label_ratedCurrent.text = [NSString stringWithFormat:@"%@A",model.electricCurrent];
    /// 电池
    [circleChart2 updateChartByCurrent:[NSNumber numberWithInteger:[model.batteryLevel integerValue]]];
    self.label_batteryLevel.text = [NSString stringWithFormat:@"%@%%",model.batteryLevel];
    /// 电压  总电压固定220V
    [circleChart3 updateChartByCurrent:[NSNumber numberWithInteger:[model.electricTension integerValue]] byTotal:[NSNumber numberWithInteger:220]];
    /// 温度 温度最大额度固定 100度
    [circleChart4 updateChartByCurrent:[NSNumber numberWithInteger:[model.boxTemperature integerValue]] byTotal:[NSNumber numberWithInteger:100]];
    /// 湿度
    [circleChart5 updateChartByCurrent:[NSNumber numberWithInteger:[model.boxTemperature integerValue]]];
    self.label_boxHumidity.text = [NSString stringWithFormat:@"%@%%",model.boxTemperature];
}

@end
