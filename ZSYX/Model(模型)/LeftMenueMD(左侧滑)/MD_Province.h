//
//  MD_Province.h
//  ZSYX
//
//  Created by cnmobi on 16/11/23.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_Province : MD_Base

/** 省名如(直辖市) */
@property (nonatomic,strong) NSString *state;
/** 某个省所有城市 */
@property (nonatomic,strong) NSArray *cities;

@end
