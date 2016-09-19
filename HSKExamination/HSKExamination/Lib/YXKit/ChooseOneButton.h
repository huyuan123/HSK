//
//  ChooseOneButton.h
//  USA
//
//  Created by YouXianMing on 14/12/9.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelRotateView.h"

@protocol ChooseOneButtonDelegate <NSObject>
@optional
- (void)chooseOneButton:(NSInteger)index;
@end

@interface ChooseOneButton : UIView

@property (nonatomic, weak) id<ChooseOneButtonDelegate> delegate;

@end
