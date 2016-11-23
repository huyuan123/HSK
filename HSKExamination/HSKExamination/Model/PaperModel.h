//
//  PaperModel.h
//  HSKExamination
//
//  Created by hiddy on 16/10/31.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ProblemModel.h"

@interface PaperModel : ProblemModel

@property (nonatomic ,strong) NSMutableArray * testPartArray ;  // 试卷的几个块

@property (nonatomic ,copy) void(^completeBlock)() ;

@end
