//
//  UINavigationController+Hide.h
//  PM2.5
//
//  Created by YouXianMing on 14/10/22.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Hide)
/**
 *  隐藏NavigationBar
 */
- (void)setHideNavigationBar:(BOOL)hide;
- (BOOL)hideNavigationBar;

@end
