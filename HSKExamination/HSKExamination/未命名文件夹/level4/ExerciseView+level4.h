//
//  ExerciseView+level4.h
//  HSKExamination
//
//  Created by hiddy on 16/10/9.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "SingleChoice1.h"
#import "TextEntry.h"
@interface ExerciseView (level4)<UITextFieldDelegate>

- (void)loadSingleChoice4:(SingleChoice1 *)model ;

- (void)loadTextEntry:(TextEntry *)entry ;
@end
