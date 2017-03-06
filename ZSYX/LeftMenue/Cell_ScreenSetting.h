//
//  Cell_ScreenSetting.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_ScreenGetInfor.h"
#import "MainHeader.h"

@interface Cell_ScreenSetting : UICollectionViewCell
/// 返回到VC_ScreenSetting.h页面的block
@property (nonatomic, copy) void(^typeReturnScreenSettingBlock)(BOOL);

///背景图片
@property IBOutlet UIImageView *imageView_Bg;
///选中图片
@property IBOutlet UIImageView *imageView_Select;
/// 底部文字
@property IBOutlet UILabel * label_Title;
///对应值的模型
@property (nonatomic, strong) MD_ScreenGetInfor *model;

/// 背景图片
@property IBOutlet UIButton * button_Bg;

@end
