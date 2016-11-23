//
//  RealExerciseView+level1.h
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "Judgement1.h"
#import "SingleChoice1.h"
#import "ReadingComprehensionModel1.h"
@interface RealExerciseView (level1)
- (void)loadJudgeMent1:(Judgement1 *)model ;
- (void)loadSingleChoice1:(SingleChoice1 *)model ;
- (void)loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model ;

@end
