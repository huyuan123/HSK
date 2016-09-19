//
//  NSArray+Sort.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

- (void)each:(void(^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx, stop);
    }];
}

- (NSArray *)sortedWithKeyPath:(NSString *)keyPath ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor  = [[NSSortDescriptor alloc] initWithKey:keyPath
                                                                    ascending:YES];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (id)objectAt:(NSUInteger)index
{
    if (index < self.count)
    {
        return self[index];
    }
    else
    {
        return nil;
    }
}

@end
