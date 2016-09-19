//
//  NSDictionary+ToModelFile.m
//  TestPch
//
//  Created by YouXianMing on 14-9-26.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSDictionary+ToModelFile.h"
#import "TransformDictionary.h"

@implementation NSDictionary (ToModelFile)

- (void)toCreateModelFile:(NSString *)fileName
{
    if (self) {
        [TransformDictionary withDictionary:self fileName:fileName];
    }
}

@end
