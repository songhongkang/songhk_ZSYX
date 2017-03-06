//
//  MD_ScreenGetInfor.h
//  ZSYX
//
//  Created by cnmobi on 2016/12/8.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MD_Base.h"

@interface MD_ScreenGetInfor : MD_Base

@property NSString *ID;
/// 类型名
@property NSString *name;
/// 图片地址，以|分隔，图片地址为相对路径，访问时需要在每张图片的地址前加上前缀： http://120.24.54.188
@property NSString *imgUrl;
/// 排序
@property NSString *sequence;

///是否选中
@property BOOL isSelect;

@end
