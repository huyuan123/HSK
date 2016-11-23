//
//  RealExerciseView+level4.h
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "SingleChoice1.h"
#import "TextEntry.h"
#import "ExtendedText4.h"
#import "ReadingComprehensionModel4.h"
@interface RealExerciseView (level4)<UITextFieldDelegate>

- (void)loadSingleChoice4:(SingleChoice1 *)model ;

- (void)loadTextEntry:(TextEntry *)entry ;

- (void)loadExTendedText:(ExtendedText4 *)model ;

- (void)loadReadingComprehensionModel4:(ReadingComprehensionModel4 *)model ;


@end
