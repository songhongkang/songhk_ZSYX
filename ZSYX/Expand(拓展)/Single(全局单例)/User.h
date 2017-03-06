//
//  User.h
//  GsyTouangou_IOS
//
//  Created by cnmobi on 16/7/1.
//  Copyright © 2016年 cnmobi. All rights reserved.
//  用户信息

#import <Foundation/Foundation.h>
#import "MD_Base.h"

@interface User : MD_Base


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *headImg;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *nickName;

@end
