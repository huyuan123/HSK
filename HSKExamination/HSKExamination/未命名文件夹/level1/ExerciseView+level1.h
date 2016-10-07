//
//  ExerciseView+level1.h
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "Judgement1.h"
#import "SingleChoice1.h"
#import "ReadingComprehensionModel1.h"
@interface ExerciseView (level1)
- (void)loadJudgeMent1:(Judgement1 *)model ;
- (void)loadSingleChoice1:(SingleChoice1 *)model ;
- (void)loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model ;

@end
