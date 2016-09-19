//
//  NSString+DES.h
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

// 加密字符串
- (NSString *)enCryptStringWithKey:(NSString *)key;

// 解密字符串
- (NSString *)deCryptStringWithKey:(NSString *)key;

@end
