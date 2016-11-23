//
//  RealExerciseView+level5.h
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "SingleChoice3.h"
#import "ReadingComprehensionModel5.h"
#import "Cloze.h"

@interface RealExerciseView (level5)

- (void)loadReadingComprehensionModel5:(ReadingComprehensionModel5 *)model ;

- (void)loadCloze:(Cloze *)model ;

- (void)loadSingleChoice5:(SingleChoice3 *)model ;

@end
