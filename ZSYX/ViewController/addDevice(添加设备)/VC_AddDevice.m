//
//  VC_AddDevice.m
//  ZSYX
//
//  Created by cnmobi on 16/11/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_AddDevice.h"

@interface VC_AddDevice ()

@end

@implementation VC_AddDevice

#pragma mark - ====================helper====================
- (void)initData
{
    
    
}

- (void)initLayout
{
    [self initScorllView];
    //添加自控制器
    [self addChildVC];
    //设置默认控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    [self scrollViewDidScroll:self.contentScrollView];
    
    
    [NOTIFY addObserver:self selector:@selector(setChangeContentOffset:) name:ConfigurationSettingsNotifcation object:nil];
}

- (void)setChangeContentOffset:(NSNotification *)notification
{
    NSArray *array = notification.object;
    NSInteger index = [array[0] integerValue];
    CGPoint  offset = self.contentScrollView.contentOffset;
    offset.x = index * SCREEN_WIDTH;
    //让内容的scollView 滚动到相应位置
    
    [self.contentScrollView setContentOffset:offset animated:YES];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

-(void)initScorllView
{
    //初始化内容scrollView
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentScrollView.backgroundColor = [UIColor colorWithRed:0.173 green:0.173 blue:0.224 alpha:1.000];
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
//    _contentScrollView.scrollEnabled = NO;
    [self.view addSubview:_contentScrollView];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
}
-(void)addChildVC
{
//    for (int i = 0; i< 7; i++) {
//        
//        CeshiTableViewController *ceshiVC = [[CeshiTableViewController alloc]init];
//        NSString *title = [NSString stringWithFormat:@"标题%d",i+1];
//        ceshiVC.title = title;
//        [self addChildViewController:ceshiVC];
//        
//    }
    
    for (int i = 0; i < 3; i++) {
        if (i == 0) {
            VC_ReadyAdd * VC = [[VC_ReadyAdd alloc] init];
            [self addChildViewController:VC];
        }
        if (i == 1) {
            VC_ConnectInternet * VC = [[VC_ConnectInternet alloc] init];
            [self addChildViewController:VC];
        }
        if (i == 2) {
            VC_ConfigurationSettings * VC = [[VC_ConfigurationSettings alloc] init];
            [self addChildViewController:VC];
        }
    }
}



#pragma mark -- scrollView Delegate
/**
 *  人为的拖拽 会调用
 *
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -- 核心代码
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //取出需要显示的控制器
    //拿到索引
    NSInteger  index =  scrollView.contentOffset.x/scrollView.frame.size.width;
    UIViewController *willShow =  self.childViewControllers[index];
    /**
     *  标题自动居中
     */
    //当前的位置的已经显示过了 就直接返回
    if ([willShow isViewLoaded]) {
        return;
    }
    willShow.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [self.contentScrollView addSubview:willShow.view];
}

/**
 *  实时监控scrollView 的滚动
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
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
