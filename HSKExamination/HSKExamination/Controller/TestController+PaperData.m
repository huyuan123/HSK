//
//  TestController+PaperData.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TestController+PaperData.h"

@implementation TestController (PaperData)
- (void)loadExaDataWithLevel:(int)level  // 根据等级加载试卷数据
{
    NSDictionary * dic = UserDefaultObjectForKet(TestDataSoure);
    NSArray * arr = dic[[NSString  stringWithFormat:@"%d",level]];
    int index = arc4random()%arr.count ;
    NSDictionary * paperDic = arr[index];
    NSString * paperName = paperDic[FileName];
    
    NSString *    path = [NSString stringWithFormat:@"%@/%@/%@",IpadPath,paperName,@"TestPaperPackageInfo.xml"];
    NSFileManager * maner = [NSFileManager defaultManager];
    if ([maner fileExistsAtPath:path]) {
        [User shareInstance].paperPath = [IpadPath stringByAppendingPathComponent:paperName];
        self.paperInfoModel = [[TestPaperPackageInfoModel alloc] init];
        [self.paperInfoModel parseInPath:paperName];
        self.astModel = [[ASTModel alloc] init];
        [self.astModel parseInPath:[paperName stringByAppendingPathComponent: self.paperInfoModel.href]];

    }else
    {
        [maner removeItemAtPath:[NSString stringWithFormat:@"%@/%@",IpadPath,paperName] error:nil];
    }
}
@end
