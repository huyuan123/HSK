//
//  ExerciseView+level6.h
//  HSKExamination
//
//  Created by hiddy on 16/10/12.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "SingleChoice1.h"
#import "ReadingComprehensionModel6.h"
#import "SingleChoice6.h"
#import "ReadingComprehensionModel7.h"
#import "ExtendedText.h"

@interface ExerciseView (level6)

- (void)loadSingleChoice6:(SingleChoice1 *)model ;

- (void)loadReadingComprehensionModel6:(ReadingComprehensionModel6 *)model ;

- (void)loadSingle6:(SingleChoice6 *)model ;

- (void)loadReadingComprehensionModel7:(ReadingComprehensionModel7 *)model ;

- (void)loadExtendedText:(ExtendedText *)model ;
@end
