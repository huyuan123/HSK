//
//  UITheme.h
//  PM2.5
//
//  Created by YouXianMing on 14/10/22.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITheme : NSObject

/**
 *  定制导航栏控制器的主题颜色,字体颜色,按钮颜色
 *
 *  @param barColor    主题颜色
 *  @param textColor   字体颜色
 *  @param buttonColor 按钮颜色
 */
+ (void)customizeNavigationBarColor:(UIColor *)barColor
                          textColor:(UIColor *)textColor
                        buttonColor:(UIColor *)buttonColor;

/**
 *  定制导航栏控制器的主题颜色,字体颜色,字体名字,字体尺寸,字体颜色
 *
 *  @param barColor    主题颜色
 *  @param textColor   字体颜色
 *  @param fontName    字体名字
 *  @param fontSize    字体尺寸
 *  @param buttonColor 按钮颜色
 */
+ (void)customizeNavigationBarColor:(UIColor *)barColor
                          textColor:(UIColor *)textColor
                           fontName:(NSString *)fontName
                           fontSize:(CGFloat)fontSize
                        buttonColor:(UIColor *)buttonColor;

@end
