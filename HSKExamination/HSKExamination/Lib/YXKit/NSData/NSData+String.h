//
//  NSData+String.h
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (String)

// 转换UTF8字符串
- (NSString *)toUTF_8_String;

// 转换UTF16字符串
- (NSString *)toUTF_16_String;

@end
