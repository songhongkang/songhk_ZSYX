//
//  MD_Electric.h
//  ZSYX
//
//  Created by cnmobi on 16/12/9.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_Electric : MD_Base
/// 日期
@property (nonatomic, strong) NSString *createDate;
/// 电量
@property (nonatomic, strong) NSNumber *value;

@end
