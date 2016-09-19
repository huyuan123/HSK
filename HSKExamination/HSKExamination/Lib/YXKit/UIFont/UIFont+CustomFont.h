//
//  UIFont+Custom.h
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (CustomFont)

+ (void)registerFontFamily:(NSString *)fontPath withName:(NSString *)name;
+ (NSDictionary *)systomAllFontsFamilyInfo;

@end
