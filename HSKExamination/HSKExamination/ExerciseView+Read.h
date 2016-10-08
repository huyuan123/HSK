//
//  ExerciseView+Read.h
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "Judgement.h"
#import "ReadingComprehensionModel.h"
@interface ExerciseView (Read)

- (void)loadReadJudgement:(Judgement *)judgeModel ;

- (void)loadReadReadModel:(ReadingComprehensionModel *)model ;

@end
