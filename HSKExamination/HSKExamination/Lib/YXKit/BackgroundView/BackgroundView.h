//
//  BackgroundView.h
//  TestHUD
//
//  Created by YouXianMing on 14-9-30.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView

@property (nonatomic, assign) NSTimeInterval  startFadeDuration; // 动画开始时持续时间
@property (nonatomic, assign) NSTimeInterval  endFadeDuration;   // 动画结束时持续时间

- (instancetype)initInView:(UIView *)view;

// 开始附加到view中
- (void)addToView;

// 将自己从view中移除掉
- (void)removeSelf;

// 显示时间
+ (void)showBackViewWithstartFadeDuration:(NSTimeInterval)startFadeDuration
                          endFadeDuration:(NSTimeInterval)endFadeDuration
                          dismissDuration:(NSTimeInterval)duration;

@end
