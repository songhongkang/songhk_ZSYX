//
//  Cell_IndexCollection.h
//  ZSYX
//
//  Created by cnmobi on 2016/11/16.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_Switchs.h"
@interface Cell_IndexCollection : UICollectionViewCell

@property IBOutlet UILabel * label_Title;
@property IBOutlet UIButton * button_ResizeName;

///
@property (nonatomic, strong) MD_Switchs *model;

@end
