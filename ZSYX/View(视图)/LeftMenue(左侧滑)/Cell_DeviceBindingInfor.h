//
//  Cell_DeviceBindingInfor.h
//  ZSYX
//
//  Created by cnmobi on 16/10/31.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_DeviceBindingInfor.h"
@interface Cell_DeviceBindingInfor : UITableViewCell

/// 取消共享的按钮
@property IBOutlet UIButton * button_CancleShare;
/// 昵称
@property IBOutlet UILabel * label_NickName;

///模型
@property (nonatomic, strong) MD_DeviceBindingInfor *model;

@end
