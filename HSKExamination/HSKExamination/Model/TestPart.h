//
//  testPart.h
//  HSKExamination
//
//  Created by printer on 9/8/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestPart : NSObject

@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID // po1  听力  po2  阅读   po3  写作

@property (nonatomic ,strong) NSString * navigationMode ;  // 试卷ID

@property (nonatomic ,strong) NSString * rubricBlock ;  // 开始提示
@property (nonatomic ,strong) NSString * endBlock ;  // 结束提示
@property (nonatomic ,strong) NSMutableArray *  assessmentSectionArray ; // 部分，第一部分，第二部分的数据

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
