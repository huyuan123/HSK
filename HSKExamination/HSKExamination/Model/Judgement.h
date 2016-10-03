//
//  Judgement.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
#import "Media.h"
#import "Img.h"
#import "ProblemModel.h"
typedef enum {
    hear ,
    reading
}JudgementType ;

@interface Judgement : ProblemModel  //  判断题
@property (nonatomic ,strong) NSMutableArray*       simpleChoiceArray ;
@property (nonatomic ,strong) Media         *       media ;
@property (nonatomic ,strong) Img           *       img ;
@property (nonatomic ,strong) NSString      *       correctResponse ;
@property (nonatomic ,assign) JudgementType         judgeType ;


@property (nonatomic ,strong) NSString      *       textString ;
@property (nonatomic ,strong) NSString      *       pinyinString ;

@end
