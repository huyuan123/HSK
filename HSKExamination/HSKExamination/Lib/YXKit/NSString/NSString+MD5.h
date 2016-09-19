//
//  NSString+MD5.h
//  Category
//
//  Created by YouXianMing on 14-8-30.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

// 返回字符串MD5值(支持值的大小写)
- (NSString *)MD5HashLower:(BOOL)lower;
//- (NSString *)md5 ;
@end
