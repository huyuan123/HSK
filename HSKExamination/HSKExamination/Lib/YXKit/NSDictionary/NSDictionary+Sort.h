//
//  NSDictionary+Sort.h
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Sort)

// 遍历字典
- (void)each:(void(^)(id key, id obj, BOOL *stop))block;

// key都为string的时候,用来返回排好序的key(有升序降序之分)
- (NSArray *)sortedStringKeysWithAscending:(BOOL)ascending;

@end
