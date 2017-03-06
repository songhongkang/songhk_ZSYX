//
//  CnmobiAppManagement.h
//  testApp
//
//  Created by cnmobi1 on 14-4-1.
//  Copyright (c) 2014年 huayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CnmobiAppManagement : NSObject

#pragma mark - ShareRequestCacheInit
+(CnmobiAppManagement *)ManagementInit;

#pragma mark - ManagementApp
-(void)ManagementWithAppName:(NSString *)appName;

@end
