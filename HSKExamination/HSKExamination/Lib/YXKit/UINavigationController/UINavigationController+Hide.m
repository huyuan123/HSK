//
//  UINavigationController+Hide.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/22.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UINavigationController+Hide.h"

@implementation UINavigationController (Hide)

- (void)setHideNavigationBar:(BOOL)hide {
    [self setNavigationBarHidden:hide];
}

- (BOOL)hideNavigationBar {
    return self.isNavigationBarHidden;
}

@end
