//
//  UIWindow+Window.m
//  Window
//
//  Created by YouXianMing on 14-10-10.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIWindow+Window.h"

@implementation UIWindow (Window)

+ (UIWindow *)usableWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIWindow *)rootWindow
{
    return [[[UIApplication sharedApplication] delegate] window];
}

@end
