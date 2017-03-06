//
//  VC_ReadyAdd.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_ReadyAdd.h"

@interface VC_ReadyAdd ()

@end

@implementation VC_ReadyAdd
#pragma mark - ====================helper====================
- (void)initData
{
    
}

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT;
}

- (IBAction)btnClick:(UIButton *)sender
{
    [NOTIFY postNotificationName:ConfigurationSettingsNotifcation object:@[@"1"]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
