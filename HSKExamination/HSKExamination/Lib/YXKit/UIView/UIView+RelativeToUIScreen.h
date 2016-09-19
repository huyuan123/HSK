//
//  UIView+RelativeToUIScreen.h
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RelativeToUIScreen)

// 返回的等比例尺寸,但宽度与屏幕宽度相同
- (CGRect)scaleAspectFitScreenWidth;

// 返回的等比例尺寸,但高度与屏幕高度相同
- (CGRect)scaleAspectFitScreenHeight;

// 返回等比例尺寸,进行有效填充
- (CGRect)ScaleAspectFit;

@end
