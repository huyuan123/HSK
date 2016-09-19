//
//  UIView+BackgroundView.h
//  BackgroundView
//
//  Created by YouXianMing on 14-10-3.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundView.h"

typedef void (^ConfigBackgroundViewBlock)(BackgroundView *configView);

@interface UIView (BackgroundView)

- (void)showBackgroundViewAndConfig:(ConfigBackgroundViewBlock)block;
- (void)removeBackgroundView;

@end
