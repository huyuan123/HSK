//
//  UIView+ConvertRect.m
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+ConvertRect.h"

@implementation UIView (ConvertRect)

- (CGRect)rectInView:(UIView *)view
{
    return [self convertRect:self.bounds toView:view];
}

@end
