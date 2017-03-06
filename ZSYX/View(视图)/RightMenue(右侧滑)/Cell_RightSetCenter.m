//
//  Cell_RightSetCenter.m
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "Cell_RightSetCenter.h"

@implementation Cell_RightSetCenter

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
    self.imageView_Bg.image = [UIImage imageNamed:string_Img];
    self.label_Title.text = title;
}

@end
