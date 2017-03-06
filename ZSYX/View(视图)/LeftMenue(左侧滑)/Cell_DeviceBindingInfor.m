//
//  Cell_DeviceBindingInfor.m
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "Cell_DeviceBindingInfor.h"

@implementation Cell_DeviceBindingInfor

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MD_DeviceBindingInfor *)model
{
    self.label_NickName.text = model.nickName;
}

@end
