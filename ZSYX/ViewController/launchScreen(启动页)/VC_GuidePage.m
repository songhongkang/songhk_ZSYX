//
//  VC_GuidePage.m
//  ZSYX
//
//  Created by cnmobi on 2016/12/23.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "VC_GuidePage.h"
#import "DWGuidePage.h"

@interface VC_GuidePage () <DWGuidePageDelegate>

@end

@implementation VC_GuidePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DWGuidePage *guidePage = [[DWGuidePage alloc] initWithFrame:self.view.bounds];
    
    //设置代理
    guidePage.delegate = self;
    
    //为第一张=时禁止左滑
    guidePage.rightEnabled = YES;
    
    //为最后一张时禁止右滑
    guidePage.leftEnabled = YES;
    
    //隐藏pageControl
        guidePage.pageHidden = YES;
    
    //设置page未选中颜色
    guidePage.pageNormalColor = [UIColor whiteColor];
    
    //设置page选中时的颜色
    guidePage.pageSelctColor = [UIColor orangeColor];
    
//#warning 不能同时设置CenterX/CenterY时又去设置X/Y，否则会有一个生效
    //设置page的Y值
    //    guidePage.pageY = 100;
    
    //设置page的X值
    
    //    guidePage.pageX = 10;
    
    //设置page的CenterX
    //    guidePage.pageCenterX = 100;
    
    //设置page的CenterY值
    //    guidePage.pageCenterY = 200;
    
    //imageArray:图片名与image对象可以用时使用
    [guidePage dw_guidePageImageArray:@[@"pic_yingdaoye1", [UIImage imageNamed:@"pic_yingdaoye2"], @"pic_yingdaoye3"] content:^(UIView *currentView, NSInteger currentPage, NSInteger count) {
        
        if (currentPage == count) {
            
            UIButton *enter = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 70, self.view.frame.size.width - 200, 44)];
            
            enter.backgroundColor = [UIColor clearColor];
            enter.layer.borderWidth = 1;
            enter.layer.borderColor = [UIColor whiteColor].CGColor;
            
            [enter setTitle:@"立即体验" forState:UIControlStateNormal];
            
            [enter addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
            [currentView addSubview:enter];
        }
        NSLog(@"currentPage===%ld----count===%ld", currentPage, count);
    }];
    [self.view addSubview:guidePage];
}

- (void)enterClick {
    UIStoryboard *storyboard_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VC_Login *VC = [storyboard_storyboard instantiateViewControllerWithIdentifier:@"VC_Login"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    
    self.view.window.rootViewController = nav;
    [self removeFromParentViewController];
    
}

#pragma mark ---delegate
- (void)dw_guidePageViewDidGuidePage:(double)guidePage pageCount:(NSInteger)pageCount{
    if (guidePage > pageCount) {
        [self enterClick];
    }
    NSLog(@"%.2f", guidePage);
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
