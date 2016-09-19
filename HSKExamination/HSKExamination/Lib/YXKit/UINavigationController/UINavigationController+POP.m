//
//  UINavigationController+POP.m
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UINavigationController+POP.h"

#ifdef DEBUG
#define UINavigationControllerPOP_DLog(fmt, ...) NSLog((@"%@[%d]:%s:" fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __func__, ##__VA_ARGS__);
#else
#define UINavigationControllerPOP_DLog(...)
#endif

@implementation UINavigationController (POP)

- (NSArray *)popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated
{
    UIViewController *controller = nil;
    
    for (UIViewController *oneController in self.viewControllers) {
        if ([oneController isMemberOfClass:viewControllerClass]) {
            controller = oneController;
            break;
        }
    }
    
    if (controller == nil) {
        UINavigationControllerPOP_DLog(@"[警告]要pop的控制器指针为空");
        return nil;
    }
    
    return [self popToViewController:controller
                            animated:animated];
}

@end
