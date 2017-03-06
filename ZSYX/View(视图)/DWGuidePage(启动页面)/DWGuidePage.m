//
//  DWGuidePage.m
//DWGuidePageTest
//
//  Created by dwang_sui on 2016/11/8.
//  Copyright © 2016年 dwang. All rights reserved.
//
/*****************************所有的量词皆是从1开始******************************/
/*****************************Github:https://github.com/dwanghello/DWGuidePage******************************/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/

#define key_ShortVersion @"key_ShortVersion"
//获取屏幕 宽度、高度
#define DWScreen_Frame  [UIScreen mainScreen].bounds
#define DWScreen_Width  [UIScreen mainScreen].bounds.size.width
#define DWScreen_Height [UIScreen mainScreen].bounds.size.height

//偏好设置
#define DWUser_Defaults [NSUserDefaults standardUserDefaults]

#import "DWGuidePage.h"
#import "UIView+Extension.h"

@interface DWGuidePage ()

/** pageContro */
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation DWGuidePage

#pragma mark ---AppDelegate设置引导页控制器
+ (void)dw_AppDelegateGuidePageWindow:(UIWindow *)window guidePageVC:(id)guidePageVC mainVC:(id)mainVC {
    
      NSString *localShortVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:key_ShortVersion];
    
    NSString *currentShortVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    if (!localShortVersionStr || [localShortVersionStr compare:currentShortVersionStr] == NSOrderedAscending) {
        
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:key_ShortVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        window.rootViewController = guidePageVC;
        
    }else{
        
        window.rootViewController = mainVC;
        
    }
    
}

#pragma mark ---设置GuidePage内容
- (instancetype)dw_guidePageImageArray:(NSArray *)imageArray content:(void(^)(UIView *currentView, NSInteger currentPage, NSInteger count))content {
    
    CGRect rect = self.guidePageFrame;
    
    rect = self.frame;
    if (self.guidePageFrame.size.width > 0 && self.guidePageFrame.size.width > 0) {
        rect = self.guidePageFrame;
    }
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:rect];
    
    scroller.tag = imageArray.count - 1;
    
    scroller.backgroundColor = [UIColor whiteColor];
    if (self.bgColor) {
        scroller.backgroundColor = self.bgColor;
    }
    
    scroller.delegate = self;
    
    //开启分页
    scroller.pagingEnabled = YES;
    
    scroller.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < [imageArray count]; i ++) {
        
        //循环添加imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
       imageView.userInteractionEnabled = true;
        
        if ([imageArray[i] isKindOfClass:[NSString class]]) {
            
            imageView.image = [UIImage imageNamed:imageArray[i]];
            
        }else if ([imageArray[i] isKindOfClass:[UIImage class]]) {
            
            imageView.image = imageArray[i];
            
        }
        
        //设置大小与位置
        imageView.size = scroller.size;
        
        imageView.x = i * scroller.width;
        
        [scroller addSubview:imageView];
        
        
        if (content) {
            
            content(imageView, i + 1, [imageArray count]);
            
        }
    }
    
    //设置scrollView的内容大小
    [scroller setContentSize:CGSizeMake([imageArray count] * scroller.width, 0)];
    
    [self addSubview:scroller];
    
    if (!self.pageHidden) {
        
        //添加pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        //设置显示几页
        pageControl.numberOfPages = [imageArray count];
        
        //选中的颜色
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        if (self.pageSelctColor) {
            pageControl.currentPageIndicatorTintColor = self.pageSelctColor;
        }
        
        //未选中的颜色
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        if (self.pageNormalColor) {
            pageControl.pageIndicatorTintColor = self.pageNormalColor;
        }
        
        [self addSubview:pageControl];
        
        self.pageControl = pageControl;
        
        //设置位置
        pageControl.centerX = self.centerX;
        pageControl.y = self.height - 100;
        if (self.pageCenterX) {
            pageControl.centerX = self.pageCenterX;
        }
        if (self.pageCenterY) {
            pageControl.centerY = self.pageCenterY;
        }
        if (self.pageX) {
            pageControl.x = self.pageX + 30;
        }
        if (self.pageY) {
            pageControl.y = self.pageY;
        }
        
    }
    
    return self;
}

#pragma  mark ---delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //计算滑动到第几页
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
    
    if (page < 0) {
        //是否禁止右滑
        if (self.rightEnabled) {
         scrollView.scrollEnabled = NO;
        }
    }else {
        scrollView.scrollEnabled = YES;
    }
    
    if (page > scrollView.tag) {
        //是否禁止右滑
        if (self.leftEnabled) {
            scrollView.scrollEnabled = NO;
        }
        
    }else {
        scrollView.scrollEnabled = YES;
    }
    
    //delegate
    if ([self.delegate respondsToSelector:@selector(dw_guidePageViewDidGuidePage:pageCount:)]) {
        
        [self.delegate dw_guidePageViewDidGuidePage:page+1 pageCount:scrollView.tag + 1];
        
    }
    
}

@end
