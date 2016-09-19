//
//  NSData+Binary.h
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Binary)

// 将不可识别二进制文件转换为可识别的文本文件
- (NSString *)transformToVisibleString;

@end
