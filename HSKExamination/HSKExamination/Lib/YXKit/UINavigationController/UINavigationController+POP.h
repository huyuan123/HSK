//
//  UINavigationController+POP.h
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (POP)

- (NSArray *)popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated;

@end
