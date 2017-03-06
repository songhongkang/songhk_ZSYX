//
//  Singleton.h
//  GsyTouangou_IOS
//
//  Created by cnmobi on 16/5/18.
//  Copyright © 2016年 cnmobi_yu. All rights reserved.
//  单例

#import <Foundation/Foundation.h>
#import "User.h"


@interface Singleton : NSObject

@property (nonatomic) User *user;               //当前用户

/**
 * 生成一个单例
 */
+ (instancetype)shareInstance;

@end
