//
//  UIView+ConvertRect.h
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConvertRect)

// 当前view在另外一个view中的rect值
- (CGRect)rectInView:(UIView *)view;

@end
