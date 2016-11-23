//
//  NumberView.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testPart.h"
#import "assessmentItemRef.h"
//  练习部分左侧的目录view
@interface NumberView : UIView<UIAlertViewDelegate>

@property (nonatomic ,weak) UILabel *  countLabel ;

@property (nonatomic ,copy) void(^ClickBlock)(AssessmentItemRef * itemRef) ;

@property (nonatomic ,copy) void(^statisBlock)() ;

- (id)initWithFrame:(CGRect)frame andBlock:(void(^)(AssessmentItemRef * itemRef))ClickBlock ;

- (void)loadTestPart:(TestPart *)part ;

- (void)next ;

@end
