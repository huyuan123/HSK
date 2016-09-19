//
//  UIViewController+UIRectEdge.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIViewController+UIRectEdge.h"

@implementation UIViewController (UIRectEdge)

- (void)rectEdgeNone {
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

@end
