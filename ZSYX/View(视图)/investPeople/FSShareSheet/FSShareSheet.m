//
//  FSShareSheet.m
//  FSActionSheet
//
//  Created by lifution on 15/10/19.
//  Copyright © 2015年 lifution. All rights reserved.
//

#import "FSShareSheet.h"
#import "FSShareCell.h"
#import "FSShareModel.h"

#define kFSShareSheetTitleH 30
#define kFSShareSheetBtnH   44

//#define kFSShareSheetHeight (kFSShareCellHeight*1+kFSShareSheetBtnH+kFSShareSheetTitleH)
#define kFSShareSheetHeight (kFSShareCellHeight*1+kFSShareSheetTitleH)

#define screenWidth [[UIScreen mainScreen] bounds].size.width

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FSShareSheet() <UITableViewDelegate, UITableViewDataSource, FSShareCellDelegate>
{
@private
    NSString *_title;
    NSString *_cancelTitle;
    UIView   *_backgroundView;
}

@property (nonatomic, retain) UITableView *tableView;

@end

NSString * const kFSShareTableCellIdentifier = @"kFSShareTableCellIdentifier";

@implementation FSShareSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id<FSShareSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle
{
    if (!(self = super.init)) return nil;
    
    self.backgroundColor = UIColorFromRGB(0xEBEBEB);
    
    if (title && title.length > 0) _title = title; else _title = @"分享";
    if (delegate) self.delegate = delegate;
    if (cancelButtonTitle && cancelButtonTitle.length > 0) _cancelTitle = cancelButtonTitle; else _cancelTitle = @"取消";
    
    [self addSubview:self.tableView];
    
    return self;
}

// resetTableView.frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark -- getter

- (UITableView *)tableView
{
    if (_tableView) return _tableView;
    
    // 初始化tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    // 代理 && 数据源
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    // 透明背景
    _tableView.backgroundColor = [UIColor clearColor];
    // 禁止滑动
    _tableView.scrollEnabled = NO;
    // 注册缓存
    [_tableView registerClass:[FSShareCell class] forCellReuseIdentifier:kFSShareTableCellIdentifier];
    // header
    _tableView.tableHeaderView = [self headerView];
    // footerView
//    _tableView.tableFooterView = [self footerView];
    return _tableView;
}

// headerView
- (UIView *)headerView
{
    UILabel *headerLabel        = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screenWidth - 10 , kFSShareSheetTitleH)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, kFSShareSheetTitleH)];
    headerView.backgroundColor = [UIColor clearColor];
    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.textAlignment   = NSTextAlignmentLeft;
    headerLabel.font            = [UIFont systemFontOfSize:14.f];
    headerLabel.text            = _title;
    [headerView addSubview:headerLabel];
    return headerView;
}
// footerView
- (UIButton *)footerView
{
    UIButton *cancelBtn       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth, kFSShareSheetBtnH)];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    return cancelBtn;
}

#pragma mark -- public
// 弹出
- (void)show
{
    UIWindow *window      = [UIApplication sharedApplication].keyWindow;
    _backgroundView       = [[UIView alloc] initWithFrame:window.bounds];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor        = [UIColor blackColor];
    _backgroundView.userInteractionEnabled = YES;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [window addSubview:_backgroundView];
    
    self.frame = CGRectMake(0, window.bounds.size.height, window.bounds.size.width, kFSShareSheetHeight);
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.5;
        self.frame = CGRectMake(0, window.bounds.size.height-kFSShareSheetHeight, window.bounds.size.width, kFSShareSheetHeight);
    }];
}

#pragma mark -- private
// 隐藏
- (void)hide
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect newRect   = self.frame;
    newRect.origin.y = window.bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
        self.frame = newRect;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        [self removeFromSuperview];
    }];
}


#pragma mark -- delegate

#pragma mark -- UITableViewDataSource && UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFSShareCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSShareCell *cell = (FSShareCell *)[tableView dequeueReusableCellWithIdentifier:kFSShareTableCellIdentifier];
    
    NSArray *models;
    if (indexPath.row == 0) {
        FSShareModel *model1 = FSShareModel.new;
        FSShareModel *model2 = FSShareModel.new;
        FSShareModel *model3 = FSShareModel.new;
//        FSShareModel *model4 = FSShareModel.new;
        
        model1.imgName   = @"iconfont_weixinyaoqing";
        model1.title     = @"微信";
        model1.tagNumber = 1;
        model2.imgName   = @"iconfont_duanxin";
        model2.title     = @"短信";
        model2.tagNumber = 2;
        model3.imgName   = @"iconfont_erweimayaoqing";
        model3.title     = @"二维码";
        model3.tagNumber = 3;
//        model4.imgName   = @"ShareQQZone";
//        model4.title     = @"分享到QQ空间";
//        model4.tagNumber = 4;
        
        models = @[model1, model2, model3];
    } else {
        FSShareModel *model1 = FSShareModel.new;
        
        model1.imgName   = @"ShareReport";
        model1.title     = @"举报";
        model1.tagNumber = 5;
        
        models = @[model1];
    }
    
    cell.models   = models;
    cell.delegate = self;
    return cell;
}

// 点击回调
- (void)selectedButton:(UIButton *)button tag:(NSInteger)tagNumber
{
    __weak __typeof(&*self)weakSelf = self;
    // 轻微动画处理
    [self animateWithButton:button completion:^(BOOL finished) {
        // 回调调用代理传递预先自己设定的按钮Tag以执行对应功能
        if ([weakSelf.delegate respondsToSelector:@selector(shareSheet:clickedButtonAtIndex:)]) {
            [weakSelf.delegate shareSheet:weakSelf clickedButtonAtIndex:tagNumber];
        }
    }];
}

// 动画处理
- (void)animateWithButton:(UIButton *)button completion:(void (^ __nullable)(BOOL finished))completion
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:button.imageView.image];
    imageView.frame        = [button convertRect:button.bounds toView:window];
    [window addSubview:imageView];
    
    // 放大动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration             = 0.3;
    NSMutableArray      *values    = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(10.0, 10.0, 1.0)]];
    animation.values = values;
    [imageView.layer addAnimation:animation forKey:nil];
    
    __weak __typeof(&*self)weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha  = 0;
        imageView.alpha = 0;
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        [weakSelf removeFromSuperview];
        
        // block回调
        if (completion) {
            completion(YES);
        }
    }];
}

@end









