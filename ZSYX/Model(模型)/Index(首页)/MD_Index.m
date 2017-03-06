//
//  MD_Index.m
//  ZSYX
//
//  Created by cnmobi on 2016/11/16.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Index.h"
#import "MD_Switchs.h"
#import "MD_Electric.h"


@implementation MD_Index

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"switchs":[MD_Switchs class], @"equipDatas":[MD_Electric class]};
}


@end
