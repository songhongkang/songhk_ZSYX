//
//  Cell_ScreenSetting.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "Cell_ScreenSetting.h"

@implementation Cell_ScreenSetting
///实现setting方法
- (void)setModel:(MD_ScreenGetInfor *)model
{
    NSArray *string_ImgUrl = [model.imgUrl componentsSeparatedByString:@"|"];
//    [self.imageView_Bg  sd_setImageWithURL:[NSURL URLWithString:string_ImgUrl[1]] placeholderImage:Picture_Default];
    
    
    [self.button_Bg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:PICTUREURL@"%@",string_ImgUrl[1]]] forState:UIControlStateNormal];
    [self.button_Bg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:PICTUREURL@"%@",string_ImgUrl[1]]] forState:UIControlStateSelected];
    
    self.imageView_Select.hidden =NO;
    self.label_Title.text = model.name;
    if (model.isSelect) {
        self.imageView_Select.hidden =NO;
        self.button_Bg.hidden =NO;

        self.label_Title.hidden = YES;
    }else{
        self.imageView_Select.hidden = YES;
        self.button_Bg.hidden =NO;

        self.label_Title.hidden = NO;
    }
}


/// 点击背景图片的手势
- (IBAction)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.typeReturnScreenSettingBlock) {
        self.typeReturnScreenSettingBlock(sender.selected);
    }
}
@end
