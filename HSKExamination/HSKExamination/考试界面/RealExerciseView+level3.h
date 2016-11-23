//
//  RealExerciseView+level3.h
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "SingleChoice3.h"
#import "Judgement3.h"
#import "ReadingComprehensionModel3.h"
#import "Order.h"
#import "TextEntry3.h"

@interface RealExerciseView (level3)
- (void)loadSingleChoice3:(SingleChoice3 *)choice ;

- (void)loadJudgeMent3:(Judgement3 *)model ;

- (void)loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model ;
- (void)loadreadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model ;


- (void)loadOrder:(Order *)order ;

- (void)loadTextEntry3:(TextEntry3 *)model ;

@end
