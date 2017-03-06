//
//  View_PersonalCenter.m
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "View_PersonalCenter.h"

@implementation View_PersonalCenter

- (void)awakeFromNib
{
    [super awakeFromNib];
    //  把图片设置成圆形。  我这里在故事版里面设置的imageView是一个正方形(因为头像图片都是放在正方形的imageView里)
    self.button_Header.layer.cornerRadius=self.button_Header.frame.size.width/2;//裁成圆角
    self.button_Header.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    self.constraint_ToRightDistance.constant = (SCREEN_WIDTH - 50 ) / 2 - self.button_Header.frame.size.width / 2 ;
//    self.button_Header.center = CGPointMake((SCREEN_WIDTH - 50 ) / 2, SCREEN_HEIGHT / 2);
    
    self.constraint_ToRightDistanceLabel.constant = (SCREEN_WIDTH - 50 ) / 2 - self.label_Phone.frame.size.width / 2 ;

    NSLog(self.label_Phone.text,nil)
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    [self createUI];
    
    
    return self;
}

- (void)createUI
{
    self.button_Header = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button_Header.frame = CGRectMake(0, 0, 96, 96);
    self.button_Header.center = CGPointMake((SCREEN_WIDTH - 50 )  / 2, SCREEN_HEIGHT / 2);

    [self.button_Header setBackgroundImage:[UIImage imageNamed:@"btn_touxinag2"] forState:UIControlStateNormal];
    
    [self addSubview:self.button_Header];
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)btnClick:(UIButton *)sender
{
    if (self.BlockClick) {
        self.BlockClick();
    }
}

@end
