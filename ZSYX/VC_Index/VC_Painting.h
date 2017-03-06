//
//  VC_Painting.h
//  ZSYX
//
//  Created by cnmobi on 16/12/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 图表类

#import "VC_Base.h"

// 线条类型
typedef NS_ENUM(NSInteger, GraphType) {
    GraphType_BarChart, // 柱形图
    GraphType_LineChart    // 折线图
};


@interface VC_Painting : VC_Base

@property(nonatomic,assign) GraphType type;
@property (weak, nonatomic) IBOutlet UILabel *label_Title;

@end
