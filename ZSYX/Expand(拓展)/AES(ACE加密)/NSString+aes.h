//
//  NSString+aes.h
//  GsyTouangou_IOS
//
//  Created by cnmobi on 16/6/30.
//  Copyright © 2016年 cnmobi. All rights reserved.
//  分类，实现加密，验证手机号码

#import <Foundation/Foundation.h>

@interface NSString (aes)

/** 密码mid5加密*/
+(NSString *) mid5: (NSString *) inPutText;

/** 账号aes加密*/
+ (NSString *) crypt:(NSString*)recource;

/** 账号aes解密*/
+ (NSString *) decrypt:(NSString*)recource;

/** 验证手机号码是否有效*/
+ (BOOL) validateMobile:(NSString *)mobile;

@end
