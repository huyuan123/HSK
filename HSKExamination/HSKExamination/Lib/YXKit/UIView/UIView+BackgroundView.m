//
//  UIView+BackgroundView.m
//  BackgroundView
//
//  Created by YouXianMing on 14-10-3.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+BackgroundView.h"

#define TAG_DATA  0x3d2894

@implementation UIView (BackgroundView)

- (void)showBackgroundViewAndConfig:(ConfigBackgroundViewBlock)block
{
    if (self == nil) {
        return;
    }
    
    BackgroundView *backView = [[BackgroundView alloc] initInView:self];
    backView.tag = TAG_DATA;
    block(backView);
    
    [backView addToView];
}

- (void)removeBackgroundView
{
    BackgroundView *backView = (BackgroundView *)[self viewWithTag:TAG_DATA];
    if (backView) {
        [backView removeSelf];
    }
}

@end
