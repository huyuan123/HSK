//
//  UIViewController+TitleTextAttributes.h
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTitleAttribute.h"

@interface UIViewController (TitleTextAttributes)

/**
 *  设置当前控制器的标题属性
 *
 *  @param attribute 属性对象
 */
- (void)titleTextAttributes:(NCTitleAttribute *)attribute;

@end
