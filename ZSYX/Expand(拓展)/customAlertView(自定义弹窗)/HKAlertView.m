//
//  HKAlertView.m
//  ZSYX
//
//  Created by cnmobi on 2017/2/20.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "HKAlertView.h"
///alertView 宽
#define AlertW 280
///各个栏目之间的距离
#define HKSpace 10.0

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
@interface HKAlertView() <UITextFieldDelegate>


@end
@implementation HKAlertView
- (instancetype)initWithTitle:(NSString *)title withPlaceHoldTextField:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle withController:(UIViewController *)controller IsHaveTextFiled:(BOOL)isHaveTextField withFinalyProperty:(NSString *)unit;
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.currentController = controller;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor purpleColor];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 150);
        self.alertView.layer.position = self.center;
        self.isShowController = isHaveTextField;
        if (title) {
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*HKSpace, 3*HKSpace, AlertW-4*HKSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            self.titleLbl.textColor = [UIColor grayColor];
            [self.alertView addSubview:self.titleLbl];
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            if (isHaveTextField)self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*HKSpace, titleW, titleH);
            else self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 3*HKSpace, titleW, titleH);
        }
        if (isHaveTextField) {
            UIView *textFieldBackGround = [[UIView alloc] initWithFrame:CGRectMake(HKSpace, self.titleLbl.bottom +5 , AlertW - HKSpace * 2,40)];
            textFieldBackGround.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
            textFieldBackGround.layer.borderWidth = 1;
            textFieldBackGround.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.3].CGColor;
            
            
            self.messageTld = [[UITextField alloc] initWithFrame:CGRectMake(HKSpace, 0, textFieldBackGround.width - HKSpace * 5, textFieldBackGround.height)];
            self.messageTld.text = message;
            self.messageTld.textColor = [UIColor lightGrayColor];
            self.messageTld.font  = [UIFont systemFontOfSize:16];
            self.messageTld.borderStyle = UITextBorderStyleNone;
            self.messageTld.delegate = self;
            self.messageTld.returnKeyType = UIReturnKeyDone;
            UILabel *propertyLbl = [[UILabel alloc] initWithFrame:CGRectMake(textFieldBackGround.width - 30, 0, 30, textFieldBackGround.height)];
            propertyLbl.text = unit;
            propertyLbl.textColor = RGB(0, 176, 56);
            propertyLbl.font = [UIFont systemFontOfSize:16];
            
            [textFieldBackGround addSubview:propertyLbl];
            [textFieldBackGround addSubview:self.messageTld];
            [self.alertView addSubview:textFieldBackGround];
            
            ///
            [self.messageTld becomeFirstResponder];
            [self registerForKeyboardNotifications];
        }
        //两个按钮，只考虑有两个按钮的 ，一个或没有按钮的没有考虑
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.cancleBtn setBackgroundColor:[UIColor whiteColor]];
            self.cancleBtn.frame = CGRectMake(HKSpace, 100, (AlertW-3 * HKSpace)/2, 40);
            [self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            self.cancleBtn.layer.cornerRadius = 5;
            self.cancleBtn.layer.masksToBounds = YES;
            self.cancleBtn.layer.borderWidth = 1;
            self.cancleBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            [self.alertView addSubview:self.cancleBtn];
        }
        if(sureTitle && cancleTitle){
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.sureBtn setBackgroundColor:[UIColor redColor]];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame) + HKSpace, 100, (AlertW-30)/2, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:RGB(0, 176, 56)] forState:UIControlStateNormal];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:self.sureBtn];
            
            self.sureBtn.layer.cornerRadius = 5;
            self.sureBtn.layer.masksToBounds = YES;
            self.sureBtn.layer.borderWidth = 1;
            self.sureBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            
        }
        self.alertView.frame = CGRectMake(0, 0, AlertW, 150);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
    }
    return self;
}

#pragma mark - 弹出 -
- (void)showHKAlertView
{
    if (_isShowController) {
        [self.currentController.view addSubview:self];
    }else{
        UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
        [rootWindow addSubview:self];
    }
    [self creatShowAnimation];
}


- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调 -设置只有2 -- > 确定才回调

- (void)buttonEvent:(UIButton *)sender
{
    if (sender.tag == 2) {
        if ([self.delegate respondsToSelector:@selector(clickAlertViewSureBtn:withInputString:)])
            [self.delegate clickAlertViewSureBtn:self withInputString:self.messageTld.text];
        if (self.sureTypeBlock) {
            self.sureTypeBlock(self.messageTld.text);
        }
    }
    [self removeFromSuperview];
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 注册键盘通知中心获取键盘高度
// 注册键盘的通知中心
- (void)registerForKeyboardNotifications{
    // 键盘出现时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // 键盘隐藏时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// 键盘弹起,视图上弹
- (void)keyboardWillShow:(NSNotification *)aNotification{
    // 当前视图尺寸
    CGRect currentFrame = self.currentController.view.frame;
    
//    NSLog(@"currentFrame===============%lf",currentFrame.origin.y);
    currentFrame.origin.y = 64 - 100;
    self.currentController.view.frame = currentFrame;
}

// 键盘弹回，视图弹回
- (void)keyboardWillHide:(NSNotification *)aNotification{
    self.currentController.view.frame = CGRectMake(0, 64, self.currentController.view.frame.size.width, self.currentController.view.frame.size.height);
}
#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(clickAlertViewSureBtn:withInputString:)])
    [self.delegate clickAlertViewSureBtn:self withInputString:self.messageTld.text];
    [self removeFromSuperview];
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
