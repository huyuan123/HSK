//
//  ReadingComprehensionModel5.h
//  HSKExamination
//
//  Created by printer on 2016/10/11.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel.h"

@interface ReadingComprehensionModel5 : ReadingComprehensionModel

@property (nonatomic ,strong) NSMutableArray        *       subItemArr ;  //  选项数组

//@property (nonatomic ,strong) NSMutableArray        *       topicArray ;

@property (nonatomic ,strong) NSMutableArray        *       correctResponseArray ;  // 答案数组

@property (nonatomic ,strong) NSString              *       textString ;
@end
