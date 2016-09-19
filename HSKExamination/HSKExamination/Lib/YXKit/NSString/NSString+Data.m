//
//  NSString+Data.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+Data.h"

@implementation NSString (Data)

- (NSData *)toUTF8Data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
