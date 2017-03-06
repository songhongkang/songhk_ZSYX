//
//  HKAlertView.h
//  ZSYX
//
//  Created by cnmobi on 2017/2/20.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainHeader.h"
#import "UIView+Positioning.h"

@protocol HKAlertViewDelegate <NSObject>

@optional
- (void) clickAlertViewSureBtn:(UIView *)alertView withInputString:(NSString *)inputStr;
@end

@interface HKAlertView : UIView

@property (assign,nonatomic) id <HKAlertViewDelegate>delegate;

/// 回调block
@property (nonatomic, copy) void(^sureTypeBlock)(NSString *);



///弹窗
@property (nonatomic,retain) UIView *alertView;
///title
@property (nonatomic,retain) UILabel *titleLbl;
///placeHoldTextFiled
@property (nonatomic,retain) UITextField *messageTld;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
/// 显示在那个控制器
@property (nonatomic,retain) UIViewController *currentController;
/// 是否显示在控制器上面
@property BOOL isShowController;
/// 键盘的尺寸
@property (assign, nonatomic) CGSize kbSize;

- (instancetype)initWithTitle:(NSString *)title withPlaceHoldTextField:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle withController:(UIViewController *)controller IsHaveTextFiled:(BOOL)isHaveTextField withFinalyProperty:(NSString *)unit;

- (void)showHKAlertView;
@end
