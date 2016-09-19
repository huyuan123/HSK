//
//  UIWindow+Window.h
//  Window
//
//  Created by YouXianMing on 14-10-10.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Window)

/**
 *  返回keyWindow（如果keyWindow有值，代表着你可以给window添加view了）
 *
 *  @return 可以添加view并显示出来的window（如果返回为nil，说明你不能将view添加到window上去显示）
 */
+ (UIWindow *)usableWindow;

/**
 *  返回window
 *
 *  @return window（你给这个window添加的view很有可能被控制器的view覆盖而显示不了）
 */
+ (UIWindow *)rootWindow;

@end
