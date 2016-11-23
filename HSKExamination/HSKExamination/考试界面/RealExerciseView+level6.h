//
//  RealExerciseView+level6.h
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "SingleChoice1.h"
#import "ReadingComprehensionModel6.h"
#import "SingleChoice6.h"
#import "ReadingComprehensionModel7.h"
#import "ExtendedText.h"
#import "Cloze6.h"
@interface RealExerciseView (level6)

- (void)loadSingleChoice6:(SingleChoice1 *)model ;

- (void)loadReadingComprehensionModel6:(ReadingComprehensionModel6 *)model ;

- (void)loadSingle6:(SingleChoice6 *)model ;

- (void)loadReadingComprehensionModel7:(ReadingComprehensionModel7 *)model ;

- (void)loadExtendedText:(ExtendedText *)model ;

- (void)loadCloze6:(Cloze6 *)model ;
@end
