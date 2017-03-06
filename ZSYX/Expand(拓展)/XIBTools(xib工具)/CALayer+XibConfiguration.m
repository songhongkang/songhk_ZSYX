//
//  CALayer+XibConfiguration.m
//  MyApplication
//
//  Created by 彭凯敏 on 15/7/22.
//  Copyright (c) 2015年 52xiaoluo. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
