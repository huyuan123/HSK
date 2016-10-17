//
//  ExerciseView+level5.h
//  HSKExamination
//
//  Created by printer on 2016/10/11.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "ReadingComprehensionModel5.h"
#import "Cloze.h"
#import "SingleChoice3.h"
@interface ExerciseView (level5)

- (void)loadReadingComprehensionModel5:(ReadingComprehensionModel5 *)model ;

- (void)loadCloze:(Cloze *)model ;

- (void)loadSingleChoice3:(SingleChoice3 *)model ;
@end
