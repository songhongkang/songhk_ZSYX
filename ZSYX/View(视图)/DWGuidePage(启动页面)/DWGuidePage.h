//
//  DWGuidePage.h
//  DWGuidePage.h
//
//  Created by dwang_sui on 2016/11/8.
//  Copyright © 2016年 dwang. All rights reserved.
//
/*****************************Github:https://github.com/dwanghello/DWGuidePage******************************/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DWGuidePageDelegate <NSObject>

@optional
/** 获取运动状态 */
- (void)dw_guidePageViewDidGuidePage:(double)guidePage pageCount:(NSInteger)pageCount;

@end

@interface DWGuidePage : UIView<UIScrollViewDelegate>

/************************************GuidePageView********************************/

/** guidePage的Size/默认当前View大小(不建议修改) */
@property(assign, nonatomic) CGRect      guidePageFrame;

/** 背景颜色/默认白色 */
@property(strong, nonatomic) UIColor    *bgColor;

/** 第一张时是否禁止右滑/默认NO */
@property(assign, nonatomic) BOOL        rightEnabled;

/** 最后一张时是否禁止左滑/默认NO */
@property(assign, nonatomic) BOOL        leftEnabled;
/*******************************************************************************/



/************************************PageControl********************************/

/** 是否显示pageControl/默认NO(不隐藏) */
@property(assign, nonatomic) BOOL        pageHidden;

/** pageControl未选中时的颜色/默认灰色 */
@property(strong, nonatomic) UIColor    *pageNormalColor;

/** pageControl选中时的颜色/默认白色 */
@property(strong, nonatomic) UIColor    *pageSelctColor;

/** pageControl中心点X值/默认当前视图中心点 */
@property(assign, nonatomic) CGFloat     pageCenterX;

/** pageControl中心点Y值/默认未使用此参数 */
@property(assign, nonatomic) CGFloat     pageCenterY;

/** pageControl的X值 */
@property(assign, nonatomic) CGFloat     pageX;

/** pageControl的Y值 */
@property(assign, nonatomic) CGFloat     pageY;
/*******************************************************************************/



/************************************操作数据********************************/

/** delagate */
@property(assign, nonatomic) id <DWGuidePageDelegate>delegate;

/**
 AppDelegate中调用

 @param window         主window
 @param guidePageVC    引导页控制器
 @param mainVC         首页控制器
 */
+ (void)dw_AppDelegateGuidePageWindow:(UIWindow *)window guidePageVC:(id)guidePageVC mainVC:(id)mainVC;

/**
 设置GuidePage数据

 @param imageArray       内容数组(图片名/image对象)
 @param content          当前内容(currentView当前引导页视图/currentPage当前引导页页码/count视图总量)
 @return <#return value description#>
 */
- (instancetype)dw_guidePageImageArray:(NSArray *)imageArray content:(void(^)(UIView *currentView, NSInteger currentPage, NSInteger count))content;
/******************************************************************************/
@end
