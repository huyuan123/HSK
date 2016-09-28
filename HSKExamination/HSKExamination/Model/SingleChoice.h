//
//  SingleChoice.h
//  HSKExamination
//
//  Created by printer on 9/27/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ProblemModel.h"
#import "Media.h"
#import "Img.h"
//  单选题
@interface SingleChoice : ProblemModel

@property (nonatomic ,strong) NSString              *       correctResponse ;

@property (nonatomic ,strong) NSMutableArray        *       simpleChoiceArray ;

@property (nonatomic ,strong) Media                 *       media ;

@property (nonatomic ,strong) NSMutableArray        *       imgArr ;

@end
