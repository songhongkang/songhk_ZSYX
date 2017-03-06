//
//  Cell_RightSetCenter.h
//  ZSYX
//
//  Created by cnmobi on 16/10/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_RightSetCenter : UITableViewCell

@property IBOutlet UIImageView *imageView_Bg;
@property IBOutlet UILabel * label_Title;
@property IBOutlet UILabel * label_Right;

- (void)setImage:(NSString *)string_Img withTitle:(NSString *)title;

@end
