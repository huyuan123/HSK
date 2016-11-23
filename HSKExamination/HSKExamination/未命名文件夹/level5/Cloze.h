//
//  Cloze.h
//  HSKExamination
//
//  Created by printer on 2016/10/12.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ProblemModel.h"
#import "Media.h"

@interface Cloze : ProblemModel

@property (nonatomic ,strong) NSMutableArray    *       correctResponseArray ;

@property (nonatomic ,strong) NSString          *       textString ;

@property (nonatomic ,strong) NSString          *       examString ;

@property (nonatomic ,strong) NSMutableArray    *       subItemArr ;

@property (nonatomic ,strong) NSMutableArray    *       titleArray ;

@property (nonatomic ,strong) Media             *       media ;

@property (nonatomic ,assign) int                       i ;

@end






































