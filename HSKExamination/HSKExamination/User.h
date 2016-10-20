//
//  User.h
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssessmentItemRef.h"
@interface User : NSObject

@property (nonatomic ,strong) NSString *  testDownLoadUrl ;

@property (nonatomic ,strong) NSString *  paperPath ;

@property (nonatomic ,assign) int   level ;      //  等级


+ (User *)shareInstance ;

+ (NSMutableDictionary *)dictionaryWithLevel:(int)level ;

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model ;

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model andIndex:(NSString *)index;

@end
