//
//  BackgroundView.m
//  TestHUD
//
//  Created by YouXianMing on 14-9-30.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "BackgroundView.h"

#ifdef DEBUG
#define BackgroundView_DLog(fmt, ...) NSLog((@"BackgroundView.m:%s:%d" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define BackgroundView_DLog(...)
#endif

@interface BackgroundView ()

@property (nonatomic, weak) UIView   *inView;

@end

@implementation BackgroundView

- (instancetype)initInView:(UIView *)view
{
    self = [super initWithFrame:view.bounds];
    if (self) {
        _inView              = view;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        self.alpha           = 0;
    }
    return self;
}

- (void)addToView
{
    // 添加到view中
    [_inView addSubview:self];
    
    // 开始执行动画
    NSTimeInterval duration = 0.2;
    if (_startFadeDuration > 0) {
        duration = _startFadeDuration;
    }
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.f;
    }];
}

- (void)removeSelf
{
    // 开始执行动画
    NSTimeInterval duration = 0.2;
    if (_endFadeDuration > 0) {
        duration = _endFadeDuration;
    }
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    BackgroundView_DLog(@" 安全释放");
}

+ (void)showBackViewWithstartFadeDuration:(NSTimeInterval)startFadeDuration
                          endFadeDuration:(NSTimeInterval)endFadeDuration
                          dismissDuration:(NSTimeInterval)duration {
    BackgroundView *backView = [[BackgroundView alloc] initInView:[UIWindow usableWindow]];
    backView.startFadeDuration = startFadeDuration;
    backView.endFadeDuration   = endFadeDuration;
    [backView addToView];
    [GCDQueue executeInMainQueue:^{
        [backView removeSelf];
    } afterDelaySecs:duration];
}


@end
