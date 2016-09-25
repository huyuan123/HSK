//
//  TestController+PaperData.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TestController.h"

@interface TestController (PaperData)  // 试卷数据处理
- (void)loadExaDataWithLevel:(int)level ; // 根据等级加载试卷数据
@end
