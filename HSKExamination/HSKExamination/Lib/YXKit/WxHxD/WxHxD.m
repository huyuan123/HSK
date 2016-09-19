//
//  WxHxD.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "WxHxD.h"

@implementation WxHxD

+ (CGFloat)appHeight {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)statusBarHeight {
    return 20.f;
}

+ (CGFloat)navigationBarHeight {
    return 44.f;
}

+ (CGFloat)tabbarHeight {
    return 49.f;
}

+ (CGFloat)statusBarAndNavigationBarHeight {
    return (20.f + 44.f);
}

@end
