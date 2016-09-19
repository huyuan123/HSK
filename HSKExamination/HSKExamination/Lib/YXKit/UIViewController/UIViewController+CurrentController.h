//
//  UIViewController+CurrentController.h
//  AlertVIewDemo
//
//  Created by YouXianMing on 14-9-29.
//  Copyright (c) 2014年 vish. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 UIViewController *viewController = [UIViewController currentController];
 if ([viewController isKindOfClass:[UINavigationController class]]) {
 UINavigationController *ncViewController = (UINavigationController *)viewController;
 NSLog(@"%@", ncViewController.visibleViewController);
 } else {
 NSLog(@"%@", viewController);
 }
 */

@interface UIViewController (CurrentController)


+ (UIViewController *)currentController;
- (void)openPhoto ;
- (void)openCamer ;
- (void)openPhotoLibry ;

@end
