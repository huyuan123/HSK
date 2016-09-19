//
//  RotateView.m
//  RotateAnimationView
//
//  Created by YouXianMing on 14/12/8.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "RotateView.h"

static CGFloat defaultDuration = 0.25f;

typedef enum : NSUInteger {
    UIVIEW_normalInputView = 0xEEFF,
    UIVIEW_disableInputView,
} EnumRotateView;

@interface RotateView ()
@property (nonatomic, assign) CGAffineTransform  defaultTransform;
@end

@implementation RotateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _defaultTransform = self.transform;
    }
    return self;
}

#pragma mark - 动画的执行
- (void)changeToUpAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_rotateDuration > 0 ? _rotateDuration : defaultDuration)
                         animations:^{
                             self.transform = _defaultTransform;
                         }];
    } else {
        self.transform = _defaultTransform;
    }

}
- (void)changeToLeftAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_rotateDuration > 0 ? _rotateDuration : defaultDuration)
                         animations:^{
                             self.transform = CGAffineTransformRotate(_defaultTransform, -M_PI_2);
                         }];
    } else {
        self.transform = CGAffineTransformRotate(_defaultTransform, -M_PI_2);
    }
}
- (void)changeToRightAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_rotateDuration > 0 ? _rotateDuration : defaultDuration)
                         animations:^{
                             self.transform = CGAffineTransformRotate(_defaultTransform, M_PI_2);
                         }];
    } else {
        self.transform = CGAffineTransformRotate(_defaultTransform, M_PI_2);
    }
}
- (void)changeTodownAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_rotateDuration > 0 ? _rotateDuration : defaultDuration)
                         animations:^{
                             self.transform = CGAffineTransformRotate(_defaultTransform, M_PI);
                         }];
    } else {
        self.transform = CGAffineTransformRotate(_defaultTransform, M_PI);
    }
}
- (void)fadeToNormalInputViewAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_fadeDuration > 0 ? _fadeDuration : defaultDuration)
                         animations:^{
                             [self viewWithTag:UIVIEW_normalInputView].alpha = 1.f;
                         }];
    } else {
        [self viewWithTag:UIVIEW_normalInputView].alpha = 1.f;
    }
}
- (void)fadeToDisableInputViewAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:(_fadeDuration > 0 ? _fadeDuration : defaultDuration)
                         animations:^{
                             [self viewWithTag:UIVIEW_normalInputView].alpha = 0.f;
                         }];
    } else {
        [self viewWithTag:UIVIEW_normalInputView].alpha = 0.f;
    }
}

#pragma mark - 重写setter，getter方法
@synthesize normalInputView = _normalInputView;
- (void)setNormalInputView:(UIView *)normalInputView {
    normalInputView.frame                  = normalInputView.bounds;
    normalInputView.userInteractionEnabled = NO;
    normalInputView.tag                    = UIVIEW_normalInputView;
    [self addSubview:normalInputView];
    
    [self bringSubviewToFront:normalInputView];
}
- (UIView *)normalInputView {
    return [self viewWithTag:UIVIEW_normalInputView];
}

@synthesize disableInputView = _disableInputView;
- (void)setDisableInputView:(UIView *)disableInputView {
    disableInputView.frame                  = disableInputView.bounds;
    disableInputView.userInteractionEnabled = NO;
    disableInputView.tag                    = UIVIEW_disableInputView;
    [self addSubview:disableInputView];
    
    [self sendSubviewToBack:disableInputView];
}
- (UIView *)disableInputView {
    return [self viewWithTag:UIVIEW_disableInputView];
}

@end
