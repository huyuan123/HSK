//
//  UIView+RelativeToUIScreen.m
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+RelativeToUIScreen.h"

#define SCR_HEIGHT             [UIScreen mainScreen].bounds.size.height
#define SCR_WIDTH              [UIScreen mainScreen].bounds.size.width

@implementation UIView (RelativeToUIScreen)

- (CGRect)scaleAspectFitScreenWidth
{
    if (self.bounds.size.height && self.bounds.size.width) {
        CGFloat calculate = SCR_WIDTH * self.bounds.size.height / self.bounds.size.width;
        CGRect rect       = CGRectMake(0, 0, SCR_WIDTH, calculate);
        return rect;
    } else {
        return CGRectZero;
    }
}

- (CGRect)scaleAspectFitScreenHeight
{
    if (self.bounds.size.height && self.bounds.size.width) {
        CGFloat calculate = SCR_HEIGHT * self.bounds.size.width / self.bounds.size.height;
        CGRect rect       = CGRectMake(0, 0, calculate, SCR_HEIGHT);
        return rect;
    } else {
        return CGRectZero;
    }
}

- (CGRect)ScaleAspectFit
{
    if (self.bounds.size.height && self.bounds.size.width) {
        if ((self.bounds.size.height / self.bounds.size.width) > (SCR_HEIGHT / SCR_WIDTH)) {
            CGFloat calculate = SCR_HEIGHT * self.bounds.size.width / self.bounds.size.height;
            CGRect rect       = CGRectMake(0, 0, calculate, SCR_HEIGHT);
            return rect;
        } else {
            CGFloat calculate = SCR_WIDTH * self.bounds.size.height / self.bounds.size.width;
            CGRect rect       = CGRectMake(0, 0, SCR_WIDTH, calculate);
            return rect;
        }
    } else {
        return CGRectZero;
    }
}

@end
