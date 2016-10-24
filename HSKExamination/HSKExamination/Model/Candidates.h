//
//  Candidates.h
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

//  考生类

@interface Candidates : NSObject


@property (nonatomic, strong) NSNumber       *DelayMinute;
@property (nonatomic, strong) NSNumber       *ExamineeArrangeID;
@property (nonatomic, strong) NSString       *Photo;  // 用户照片
@property (nonatomic, strong) NSNumber       *ExamSiteID;
@property (nonatomic, strong) NSNumber       *LastEntryTime;
@property (nonatomic, strong) NSNumber       *PaperVersion;
@property (nonatomic, strong) NSNumber       *SubjectType;
@property (nonatomic, strong) NSString       *ExamDate;
@property (nonatomic, strong) NSNumber       *SysState;
@property (nonatomic, strong) NSString       *ExamineeReportFile;
@property (nonatomic, strong) NSNumber       *ExamPlanInfoID;
@property (nonatomic, strong) NSString       *ExamineeName;
@property (nonatomic, strong) NSString       *PlanPassword;
@property (nonatomic, strong) NSString       *ExamCardNo;
@property (nonatomic, strong) NSNumber       *Sex;
@property (nonatomic, strong) NSString       *SubjectName;
@property (nonatomic, strong) NSNumber       *TimeLimits;
@property (nonatomic, strong) NSNumber       *SeatNo;
@property (nonatomic, strong) NSString       *CertificateNo;
@property (nonatomic, strong) NSString       *PaperPassword;  //  解压缩的密码
@property (nonatomic, strong) NSString       *PaperID;
@property (nonatomic, strong) NSNumber       *EnterExamSceneTime;
@property (nonatomic, strong) NSString       *PlanBeginTime;
@property (nonatomic, strong) NSString       *PlanEndTime;
@property (nonatomic, strong) NSNumber       *IsAgain;
@property (nonatomic, strong) NSNumber       *ExamineeID;
@property (nonatomic, strong) NSNumber       *ExamSubjectID;
@property (nonatomic, strong) NSString       *PaperPackageFile;  // 试卷地址
@property (nonatomic, strong) NSString       *SubjectCode;  // 等级
@property (nonatomic, strong) NSString       *Nationality;
@property (nonatomic, strong) NSString       *ApplicationRange;
@property (nonatomic, strong) NSNumber       *CertificateType;
@property (nonatomic, strong) NSString       *Pwd;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

