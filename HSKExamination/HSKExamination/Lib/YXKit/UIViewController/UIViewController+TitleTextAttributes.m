//
//  UIViewController+TitleTextAttributes.m
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIViewController+TitleTextAttributes.h"

@implementation UIViewController (TitleTextAttributes)

#pragma mark - public
- (void)titleTextAttributes:(NCTitleAttribute *)attribute
{
    [self controller:self
 titleTextAttributes:[attribute transformToDictionary]];
}

#pragma mark - private
- (void)controller:(UIViewController *)controller titleTextAttributes:(NSDictionary *)dictionary
{
    if ([controller isKindOfClass:[UIViewController class]]) {
        [controller.navigationController.navigationBar setTitleTextAttributes:dictionary];
    }
}

@end
