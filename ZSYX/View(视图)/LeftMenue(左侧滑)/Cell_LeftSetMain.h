//
//  Cell_LeftSetMain.h
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeader.h"



@interface Cell_LeftSetMain : UITableViewCell

@property IBOutlet UIImageView *imageView_Left;
@property IBOutlet UILabel * label_Title;
@property IBOutlet UIButton *button_Left;

- (void)setImage:(NSString *)string_Img withTitle:(NSString *)title;

@end
