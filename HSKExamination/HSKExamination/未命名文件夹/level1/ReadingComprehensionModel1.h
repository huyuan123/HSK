//
//  ReadingComprehensionModel1.h
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel.h"

@interface ReadingComprehensionModel1 : ReadingComprehensionModel

@property (nonatomic ,strong) NSMutableArray        *       correctResponseArray ;  // 答案数组

@property (nonatomic ,strong) Media                 *       media ;

@property (nonatomic ,strong) NSMutableArray        *       imgArray ;   //  图片数组

@property (nonatomic ,strong) NSMutableArray        *       subItemArr ;  //  选项数组

@property (nonatomic ,strong) NSMutableArray        *       topicArray ;

@end
