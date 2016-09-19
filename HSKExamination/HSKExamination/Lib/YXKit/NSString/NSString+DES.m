//
//  NSString+DES.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+DES.h"
#import "YXCrypto.h"

@implementation NSString (DES)

- (NSString *)enCryptStringWithKey:(NSString *)key
{
    return [YXCrypto DesEncryptString:self WithKey:key];
}

- (NSString *)deCryptStringWithKey:(NSString *)key
{
    return [YXCrypto DesDecryptString:self WithKey:key];
}

@end
