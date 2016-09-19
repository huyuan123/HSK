//
//  LabelRotateView.h
//  USA
//
//  Created by YouXianMing on 14/12/9.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateView.h"

@interface LabelRotateView : UIView

@property (nonatomic, strong) RotateView  *rotateView;
@property (nonatomic, strong) NSString    *title;
@property (nonatomic, assign) CGFloat      rotateViewOffsetX;

- (void)changeToNormalStateAnimated:(BOOL)animated;
- (void)changeToDisableStateAnimated:(BOOL)animated;

@end
