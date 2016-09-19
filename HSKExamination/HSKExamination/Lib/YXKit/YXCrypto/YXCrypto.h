//
//  YXCrypto.h
//  用秘钥给字符串加密或者解密
//
//  Created by YouXian on 14-3-18.
//  Copyright (c) 2014年 YouXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXCrypto : NSObject

/*!
 * 给字符串加密
 */
+ (NSString *)DesEncryptString:(NSString*)src WithKey:(NSString *)key;

/*!
 * 给字符串解密
 */
+ (NSString *)DesDecryptString:(NSString*)src WithKey:(NSString *)key;

@end
