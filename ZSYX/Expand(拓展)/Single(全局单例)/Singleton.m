//
//  Singleton.m
//  OLangcheye
//
//  Created by cnmobi on 16/5/18.
//  Copyright © 2016年 cnmobi_yu. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [Singleton shareInstance];
}

- (id)init{
    if (self == [super init]) {
        
    }
    return self;
}



@end
