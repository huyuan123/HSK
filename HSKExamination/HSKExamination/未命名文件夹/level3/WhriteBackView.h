//
//  WhriteBackView.h
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssessmentItemRef.h"
#import "Order.h"
@interface WhriteBackView : UIView

@property (nonatomic ,assign) int count ;

- (void)AdsorptionView:(UIView *)view andRef:(AssessmentItemRef *)ref andOrder:(Order *)order;

//- (void)AdsorptionView:(UIView *)view andRef:(AssessmentItemRef *)ref andOrder:();

@end
