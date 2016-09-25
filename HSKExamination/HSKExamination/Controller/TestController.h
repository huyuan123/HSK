//
//  TestController.h
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "BaseViewController.h"
#import "ASTModel.h"
#import "TestPaperPackageInfoModel.h"
@interface TestController : BaseViewController

@property (nonatomic ,assign) int level ;

@property (nonatomic ,strong) ASTModel * astModel ;

@property (nonatomic ,strong) TestPaperPackageInfoModel * paperInfoModel ;

@end
