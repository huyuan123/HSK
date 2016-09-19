//
//  UIView+Init.h
//  PM2.5
//
//  Created by YouXianMing on 14/10/21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Init)

/**
 *  初始化方法，并携带tag值
 *
 *  @param frame frame值
 *  @param tag   tag值
 *
 *  @return UIView对象
 */
- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;

/**
 *  初始化方法，携带tag值，并插入到指定的view中
 *
 *  @param frame frame值
 *  @param tag   tag值
 *  @param view  被插入的view
 *
 *  @return UIView对象
 */
- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag insertInView:(UIView *)view;

/**
 *  初始化方法，插入到指定的view中
 *
 *  @param frame frame值
 *  @param view  被插入的view
 *
 *  @return UIView对象
 */
- (instancetype)initWithFrame:(CGRect)frame insertInView:(UIView *)view;


- (CGFloat)disTanceWithOtherView:(UIView *)view ; //  计算此view和参数view的中心距离

@end
