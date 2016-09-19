//
//  NSDictionary+Sort.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSDictionary+Sort.h"

@implementation NSDictionary (Sort)

- (void)each:(void(^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj, stop);
    }];
}

- (NSArray *)sortedStringKeysWithAscending:(BOOL)ascending
{
    NSArray *ary       = [self allKeys];
    NSArray *sortedAry = [ary sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (ascending)
        {
            return [obj1 compare:obj2];
        }
        else
        {
            return [obj2 compare:obj1];
        }
        
    }];
    
    return sortedAry;
}

@end
