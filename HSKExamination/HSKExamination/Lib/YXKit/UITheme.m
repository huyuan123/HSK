//
//  UITheme.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/22.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UITheme.h"

@implementation UITheme

+ (void)customizeNavigationBarColor:(UIColor *)barColor
                          textColor:(UIColor *)textColor
                        buttonColor:(UIColor *)buttonColor {
    [[UINavigationBar appearance] setBarTintColor:barColor];
    [[UINavigationBar appearance] setTintColor:buttonColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:textColor}];
}

+ (void)customizeNavigationBarColor:(UIColor *)barColor
                          textColor:(UIColor *)textColor
                           fontName:(NSString *)fontName
                           fontSize:(CGFloat)fontSize
                        buttonColor:(UIColor *)buttonColor {
    [[UINavigationBar appearance] setBarTintColor:barColor];
    [[UINavigationBar appearance] setTintColor:buttonColor];
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (font) {
        [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                               NSForegroundColorAttributeName: textColor,
                                                               NSFontAttributeName: font
                                                               }];
    }
}

@end
