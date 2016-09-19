//
//  TestPaperPackageInfo.h
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
@interface TestPaperPackageInfoModel : XMLBaseModel

@property (nonatomic ,strong) NSString * TestPaperTotal ;  // 是测试试卷数量
@property (nonatomic ,strong) NSString * itemCount ;        // 为试卷题目数*************
@property (nonatomic ,strong) NSString * packageDate ;  // 创建时间 其实对于
@property (nonatomic ,strong) NSString * identifier ;
@property (nonatomic ,strong) NSString * href ;           //  这个是试卷真实的数据信息文件名*************
@property (nonatomic ,strong) NSString * TestPaperName ;  // 是试卷名*****************
@property (nonatomic ,strong) NSString * totalScore ;       //  是总分
@property (nonatomic ,strong) NSString * ItemBankSubjectID ;  //
@property (nonatomic ,strong) NSString * ItemBankSubjectName ;


@end
