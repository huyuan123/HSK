//
//  TextEntry.h
//  HSKExamination
//
//  Created by hiddy on 16/10/10.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ProblemModel.h"

@interface TextEntry : ProblemModel

@property (nonatomic ,strong) NSMutableArray *  simpleChoiceArray ;

@property (nonatomic ,strong) NSString *  correctResponse ;

@end
