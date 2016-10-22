//
//  User.h
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssessmentItemRef.h"

#define SerVerConfig    @"serVerConfig"
#define URLSerVer       @"url"
#define Server          @"Server"
#define ServerCode      @"ServerCode"
#define MiddleServer    @"MiddleServer"

@interface User : NSObject

@property (nonatomic ,strong) NSString *  testDownLoadUrl ;

@property (nonatomic ,strong) NSString *  paperPath ;

@property (nonatomic ,assign) int   level ;      //  等级

@property (nonatomic ,assign) NSString *   middleServer ;    //  10000 中央服务器   10001  考点服务器   //  等级

@property (nonatomic ,strong) NSDictionary  *  serVerConfig ;


+ (User *)shareInstance ;

+ (NSMutableDictionary *)dictionaryWithLevel:(int)level ;

+ (void)setStatisticsWithType:(NSString *)type andIScorrect:(BOOL)b ;


+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model ;

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model andIndex:(NSString *)index;

@end
