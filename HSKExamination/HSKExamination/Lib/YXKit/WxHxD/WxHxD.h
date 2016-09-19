//
//  WxHxD.h
//  PM2.5
//
//  Created by YouXianMing on 14/10/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//



#import <Foundation/Foundation.h>


@interface WxHxD : NSObject

/**
 *  应用程序中可以放置view的区间的高度(部分区域会被导航栏控制器的高度占有而不计算在类)
 *
 *  @return 高度
 */
+ (CGFloat)appHeight;

/**
 *  屏幕高度
 *
 *  @return 屏幕高度
 */
+ (CGFloat)screenHeight;

/**
 *  屏幕宽度
 *
 *  @return 屏幕宽度
 */
+ (CGFloat)screenWidth;

/**
 *  状态栏高度
 *
 *  @return 状态栏高度
 */
+ (CGFloat)statusBarHeight;

/**
 *  导航栏控制器的高度
 *
 *  @return 导航栏控制器的高度
 */
+ (CGFloat)navigationBarHeight;

/**
 *  标签栏控制器的高度
 *
 *  @return 标签栏控制器的高度
 */
+ (CGFloat)tabbarHeight;

/**
 *  状态栏与导航栏控制器一起的高度
 *
 *  @return 状态栏与导航栏控制器一起的高度
 */
+ (CGFloat)statusBarAndNavigationBarHeight;

@end
