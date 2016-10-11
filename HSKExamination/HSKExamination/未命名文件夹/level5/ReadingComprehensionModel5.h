//
//  ReadingComprehensionModel5.h
//  HSKExamination
//
//  Created by printer on 2016/10/11.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ReadingComprehensionModel.h"
#import "Media.h"
@interface ReadingComprehensionModel5 : ReadingComprehensionModel

@property (nonatomic ,strong) NSMutableArray        *       subItemArr ;  //  选项数组

@property (nonatomic ,strong) Media                 *       media ;

@property (nonatomic ,strong) NSMutableArray        *       correctResponseArray ;  // 答案数组

@property (nonatomic ,strong) NSString              *       textString ;
@end
