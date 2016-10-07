//
//  SingleChoice1.h
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SingleChoice.h"

@interface SingleChoice1 : SingleChoice

@property (nonatomic ,strong) NSString              *       correctResponse ;

@property (nonatomic ,strong) NSMutableArray        *       simpleChoiceArray ;

@property (nonatomic ,strong) Media                 *       media ;

@property (nonatomic ,strong) NSMutableArray        *       imgArr ;

@end

@interface SingleChoice2 : SingleChoice1

@end
