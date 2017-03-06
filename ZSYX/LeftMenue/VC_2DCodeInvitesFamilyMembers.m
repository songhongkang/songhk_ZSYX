//
//  VC_2DCodeInvitesFamilyMembers.m
//  ZSYX
//
//  Created by cnmobi on 2016/11/17.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_2DCodeInvitesFamilyMembers.h"
#import <HMQRCodeScanner/HMScannerController.h>

@interface VC_2DCodeInvitesFamilyMembers ()

@end

@implementation VC_2DCodeInvitesFamilyMembers

#pragma mark - ====================helper====================
- (void)initData
{

}

- (void)initLayout
{
    self.layouotConstraint_Height.constant = SCREEN_HEIGHT + 1 ;
    [self show2WeiCode];
}

- (void)show2WeiCode
{
    [HMScannerController cardImageWithCardName:self.string_2WeiCodeInfor avatar:nil scale:0.2 completion:^(UIImage *image) {
        self.imageView_2WeiMa.image = image;
    }];
}

#pragma mark - ====================BtnClick====================
- (IBAction)btnClick:(id)sender
{
    
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
