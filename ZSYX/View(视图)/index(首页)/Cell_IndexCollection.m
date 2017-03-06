//
//  Cell_IndexCollection.m
//  ZSYX
//
//  Created by cnmobi on 2016/11/16.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "Cell_IndexCollection.h"

@implementation Cell_IndexCollection

- (void)setModel:(MD_Switchs *)model
{
    self.label_Title.text = model.switchName;
    if ([model.status integerValue] == 1) {
        self.button_ResizeName.selected = YES;
    }else{
        self.button_ResizeName.selected = NO;
    }
//    self.button_ResizeName.selected = YES;
//    self.button_ResizeName.selected = NO;
}

@end
