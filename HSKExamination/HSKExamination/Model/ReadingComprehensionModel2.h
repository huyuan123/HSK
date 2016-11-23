//
//  ReadingComprehensionModel2.h
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ProblemModel.h"

@interface ReadingComprehensionModel2 : ProblemModel

@property (nonatomic ,strong) Img                   *       img ;

@property (nonatomic ,strong) Img                   *       exampleImg ;

@property (nonatomic ,strong) NSString              *       textString ;

@property (nonatomic ,strong) NSMutableArray        *       subItemArr ;  //  选项数组

@property (nonatomic ,strong) NSMutableArray        *       topicArray ;

@property (nonatomic ,strong) NSMutableArray        *       correctResponseArray ;  // 答案数组

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string ;

@end
