//
//  VC_AcountManager.h
//  ZSYX
//
//  Created by cnmobi on 16/11/4.
//  Copyright © 2016年 cnmobi. All rights reserved.
//
/// 账号管理


#import "VC_Base.h"
#import "VC_ReviseNickName.h"
@interface VC_AcountManager : VC_Base <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/// 头像
@property IBOutlet UIButton * button_Header;
/// 昵称
@property IBOutlet UIButton * button_NickName;


/// 从上个界面传过的来的信息
@property  NSDictionary * dict_Infor;
@end
