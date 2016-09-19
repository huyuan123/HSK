//
//  NSObject+FastCoder.m
//  Category
//
//  Created by YouXianMing on 14-8-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSObject+FastCoder.h"
#import "FastCoder.h"

@implementation NSObject (FastCoder)

- (BOOL)useFastCoderToWriteToPath:(NSString *)filePath
{
    BOOL sucess = NO;
    
    if (self == nil)
    {
        return sucess;
    }
    
    NSData *data = [FastCoder dataWithRootObject:self];
    sucess       = [data writeToFile:filePath atomically:YES];
    
    return sucess;
}

- (id)useFastCoderToRecoverFromPath:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    return [FastCoder objectWithData:data];
}

- (NSData *)useFastCoderToCreateData
{
    return [FastCoder dataWithRootObject:self];
}

@end
