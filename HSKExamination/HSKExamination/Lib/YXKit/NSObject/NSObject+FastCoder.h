//
//  NSObject+FastCoder.h
//  Category
//
//  Created by YouXianMing on 14-8-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FastCoder)

// 将NSObject直接写文件
- (BOOL)useFastCoderToWriteToPath:(NSString *)filePath;

// 将NSObject从文件中直接读出来
- (id)useFastCoderToRecoverFromPath:(NSString *)filePath;

// 生成NSData文件
- (NSData *)useFastCoderToCreateData;

@end
