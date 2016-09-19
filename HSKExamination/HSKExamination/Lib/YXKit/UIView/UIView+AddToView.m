//
//  UIView+AddToView.m
//  TestHUD
//
//  Created by YouXianMing on 14-10-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+AddToView.h"

@implementation UIView (AddToView)

- (void)insertIntoView:(UIView *)view {
    [view addSubview:self];
}

- (void)insertIntoView:(UIView *)view withTag:(NSInteger)tag {
    self.tag = tag;
    [view addSubview:self];
}

- (UIView *)recoverFromView:(UIView *)view WithTag:(NSInteger)tag {
    return [view viewWithTag:tag];
}

- (void)bringToFrontInView:(UIView *)view {
    [view bringSubviewToFront:self];
}

@end
