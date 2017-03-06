//
//  Cell_LeftSetMain.m
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "Cell_LeftSetMain.h"

@implementation Cell_LeftSetMain

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImage:(NSString *)string_Img withTitle:(NSString *)title
{
    self.imageView_Left.image = [UIImage imageNamed:string_Img];
    self.label_Title.text = title;
//    [self.button_Left setImage:[UIImage imageNamed:string_Img]];
    [self.button_Left setImage:[UIImage imageNamed:string_Img] forState:UIControlStateNormal];
    
}

@end
