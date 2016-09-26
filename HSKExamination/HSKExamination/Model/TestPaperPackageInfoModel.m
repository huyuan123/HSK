//
//  TestPaperPackageInfo.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "TestPaperPackageInfoModel.h"

@implementation TestPaperPackageInfoModel
- (void)parseInPath:(NSString *)path
{
    path = [NSString stringWithFormat:@"%@/%@/%@",IpadPath,path,@"TestPaperPackageInfo.xml"];
    [super parseInPath:path];
}

// TestPaperPackageInfo
@end
