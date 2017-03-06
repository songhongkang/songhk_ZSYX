//
//  CALayer+XibConfiguration.h
//  MyApplication
//
//  Created by 彭凯敏 on 15/7/22.
//  Copyright (c) 2015年 52xiaoluo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end