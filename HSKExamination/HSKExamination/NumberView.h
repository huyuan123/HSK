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
@interface NumberView : UIView

@property (nonatomic ,copy) void(^ClickBlock)(AssessmentItemRef * itemRef) ;

- (void)loadTestPart:(TestPart *)part ;

@end
