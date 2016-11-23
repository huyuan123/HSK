//
//  TestNoteView.h
//  HSKExamination
//
//  Created by hiddy on 16/11/2.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestPart.h"
#import "AssessmentSection.h"
#import "PaperModel.h"
#import "NumberButton.h"
@interface TestNoteView : UIView        //  右边上方的说明view

@property (nonatomic ,copy) void(^nextBlock)() ;

@property (nonatomic ,copy) void(^hearBackBlock)(int index) ;  // 听力回顾的block

@property (nonatomic ,weak) PaperModel      *   paperModel ;

@property (nonatomic ,weak) NumberButton    *   itemBu ;

@property (nonatomic ,strong) UIButton      *   endButton ;

@property (nonatomic ,assign) ASTIndex      index ;

@property (nonatomic ,strong) UILabel * clockLabel ;

- (void)startTime ;

- (void)setClockStringWithSec:(int)sec ;

- (BOOL)isClock ;

- (void)endBuEvent:(UIButton *)bu ;

- (void)hearBackWithTime:(int)time ;

@end
