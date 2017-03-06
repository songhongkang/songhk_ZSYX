//
//  VC_PhotoModel.h
//  ZSYX
//
//  Created by cnmobi on 16/11/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 图片设置

#import "VC_Base.h"
#import "ActionSheetStringPicker.h"
#import "MD_Index.h"


@interface VC_PhotoModel : VC_Base

@property (weak, nonatomic) IBOutlet UILabel *label_changPhoto;

@property (weak, nonatomic) IBOutlet UILabel *label_continueTime;

@property (weak, nonatomic) IBOutlet UILabel *label_CurrentModel;

/// uiscrollview的高度
@property IBOutlet NSLayoutConstraint *layouotConstraint_Height;

@end
