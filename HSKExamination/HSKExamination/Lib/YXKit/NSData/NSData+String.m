//
//  NSData+String.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSData+String.h"

@implementation NSData (String)

- (NSString *)toUTF_8_String
{
    return [[NSString alloc] initWithData:self
                                 encoding:NSUTF8StringEncoding];
}

- (NSString *)toUTF_16_String
{
    return [[NSString alloc] initWithData:self
                                 encoding:NSUTF16StringEncoding];
}

@end
