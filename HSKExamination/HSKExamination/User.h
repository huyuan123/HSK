//
//  User.h
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssessmentItemRef.h"
#import "Candidates.h"
#import "AudioManger.h"
#import "NetWorking.h"
#import "AgainExamModel.h"

#define SerVerConfig    @"serVerConfig"
#define URLSerVer       @"url"
#define Server          @"Server"
#define ServerCode      @"ServerCode"
#define MiddleServer    @"MiddleServer"

#define UserResData    @"UserResData"
#define ExamCardNumber     @"ExamCardNo"




@interface User : NSObject

@property (nonatomic ,strong) NSString *  testDownLoadUrl ;

@property (nonatomic ,strong) NSString *  paperPath ;

@property (nonatomic ,assign) int   level ;      //  等级

@property (nonatomic ,assign) NSString *   middleServer ;    //  10000 中央服务器   10001  考点服务器   //  等级

@property (nonatomic ,strong) NSDictionary  *  serVerConfig ;

@property (nonatomic ,strong) Candidates  *  candiateModel ;

@property (nonatomic ,strong) AgainExamModel  *  againModel ;

@property (nonatomic ,strong) AudioManger *  audioManger ;

@property (nonatomic ,assign) AFNetworkReachabilityStatus netStatus ;


+ (User *)shareInstance ;

+ (NSMutableDictionary *)dictionaryWithLevel:(int)level ;

+ (void)setStatisticsWithType:(NSString *)type andIScorrect:(BOOL)b ;

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model ;

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model andIndex:(NSString *)index;

+ (NSString *)typeNumberWithType:(NSString *)type ;

+ (void)saveUserRes:(AssessmentItemRef *)model ;

@end
