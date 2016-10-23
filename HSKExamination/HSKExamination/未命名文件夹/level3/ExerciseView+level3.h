//
//  ExerciseView+level3.h
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "Judgement3.h"
#import "ReadingComprehensionModel3.h"
#import "SingleChoice3.h"
#import "Order.h"
#import "TextEntry3.h"
@interface ExerciseView (level3)

- (void)loadJudgeMent3:(Judgement3 *)model ;

- (void)loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model ;

- (void)loadSingleChoice3:(SingleChoice3 *)model ;

- (void)loadOrder:(Order *)order ;

- (void)loadTextEntry3:(TextEntry3 *)model ;
@end
