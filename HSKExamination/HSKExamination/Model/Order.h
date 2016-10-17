//
//  Order.h
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ProblemModel.h"

@interface Order : ProblemModel

@property (nonatomic ,strong) NSString      *       correctResponse ;

@property (nonatomic ,strong) NSMutableArray*       subItemArray ;

@end
