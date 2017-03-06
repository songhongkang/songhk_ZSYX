//
//  View_PersonalCenter.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeader.h"

@interface View_PersonalCenter : UIView

/// 点击按钮的block
@property (nonatomic, copy) void(^BlockClick)(void);
/// button 属性
@property IBOutlet UIButton * button_Header;
/// Label 属性
@property IBOutlet UILabel * label_Phone;
/// button距离右侧的距离
@property IBOutlet NSLayoutConstraint *constraint_ToRightDistance;
/// label距离右侧的距离
@property IBOutlet NSLayoutConstraint *constraint_ToRightDistanceLabel;
@end
