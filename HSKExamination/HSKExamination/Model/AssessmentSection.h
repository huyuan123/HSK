//
//  AssessmentSection.h
//  HSKExamination
//
//  Created by printer on 9/12/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"
//  部分的对象，第一部分，第二部分
@interface AssessmentSection : NSObject

@property (nonatomic ,strong) NSString * identifier ; //  "S01"  第一部分    "S02" 第二部分    "S03" 第三部分
@property (nonatomic ,strong) Media    * rubricMedia ;
@property (nonatomic ,strong) NSString *title  ;
@property (nonatomic ,strong) NSString *itemCount ;


@property (nonatomic ,strong) NSString * rubricBlock ;  // 开始提示
@property (nonatomic ,strong) NSString * endBlock ;  // 结束提示


@property (nonatomic ,strong) NSMutableArray * assessmentItemRefArray ;  // 题目，这个是具体的题目的集合


- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;

@end
