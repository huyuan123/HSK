//
//  UIView+AddToView.h
//  TestHUD
//
//  Created by YouXianMing on 14-10-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddToView)

/**
 *  将自己插入到view当中
 *
 *  @param view 被插入的view
 */
- (void)insertIntoView:(UIView *)view;

/**
 *  将自己插入到view当中,并设定tag值
 *
 *  @param view 被插入的view
 *  @param tag  设定的tag值
 */
- (void)insertIntoView:(UIView *)view withTag:(NSInteger)tag;

/**
 *  从view中取出自己
 *
 *  @param view view
 *  @param tag  设定tag值
 *
 *  @return view
 */
- (UIView *)recoverFromView:(UIView *)view WithTag:(NSInteger)tag;

/**
 *  将自己从view中移到最前面
 *
 *  @param view 被插入的view
 */
- (void)bringToFrontInView:(UIView *)view;

@end
