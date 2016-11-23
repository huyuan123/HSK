//
//  UrlPath.h
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#ifndef UrlPath_h
#define UrlPath_h

#define  HskYueKao          @"http://mnks.cnhsk.org/hsk/api/reg-online"
#define  HskServerTest      @"NetExamUtility.svc/GetExamPlanList"
#define  HskLogin           @"NetExamUtility.svc/ExamLogin"
#define  SaveResponse       [[User shareInstance].serVerConfig[URLSerVer] stringByAppendingString: @"NetExamUtility.svc/SaveResponseForMobile"] 
#define  EndHearTest        [[User shareInstance].serVerConfig[URLSerVer] stringByAppendingString: @"NetExamUtility.svc/SaveResponseProgressForMobile"]
#define  SavePaper          [[User shareInstance].serVerConfig[URLSerVer] stringByAppendingString: @"NetExamUtility.svc/SubmitExamForMobile"]


#endif /* UrlPath_h */


/*
 
 [NetWorking postWithUrl:HskYueKao andParameter:@{@"nationality" : @"US",
 @"username": @"test",
 @"gender" : @1,
 @"city" : @"beijing",
 @"level": @6,
 @"phone": @"13888889999",@"email" : @"test@test.com"} andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
 NSLog(@"--------------------++++++++++++++%@",respon) ;
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 NSLog(@"--------------------++++++++++++++%@",error) ;
 }];
 
 */
