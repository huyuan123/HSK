//
//  RotateView.h
//  RotateAnimationView
//
//  Created by YouXianMing on 14/12/8.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  要注意normalInputView与disableInputView的frame值最好与RotateView的bounds值一致
 */
@interface RotateView : UIView

/**
 *  显示常规的view
 */
@property (nonatomic, strong) UIView   *normalInputView;
/**
 *  禁用状态的view
 */
@property (nonatomic, strong) UIView   *disableInputView;
/**
 *  旋转时间
 */
@property (nonatomic, assign) CGFloat   rotateDuration;
/**
 *  view切换时间
 */
@property (nonatomic, assign) CGFloat   fadeDuration;

/**
 *  旋转到向上的位置（默认的位置）
 *
 *  @param animated 是否显示动画
 */
- (void)changeToUpAnimated:(BOOL)animated;

/**
 *  旋转到向左的位置
 *
 *  @param animated 是否显示动画
 */
- (void)changeToLeftAnimated:(BOOL)animated;

/**
 *  旋转到向右的位置
 *
 *  @param animated 是否显示动画
 */
- (void)changeToRightAnimated:(BOOL)animated;

/**
 *  旋转到向下的位置
 *
 *  @param animated 是否显示动画
 */
- (void)changeTodownAnimated:(BOOL)animated;

/**
 *  渐变到显示常规的view
 *
 *  @param animated 是否显示动画
 */
- (void)fadeToNormalInputViewAnimated:(BOOL)animated;

/**
 *  渐变到禁用状态的view
 *
 *  @param animated 是否显示动画
 */
- (void)fadeToDisableInputViewAnimated:(BOOL)animated;

@end
