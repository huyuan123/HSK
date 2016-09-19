//
//  NSArray+Sort.h
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sort)

// 遍历数组
- (void)each:(void(^)(id obj, NSUInteger idx, BOOL *stop))block;

// 根据Model键值排序
- (NSArray *)sortedWithKeyPath:(NSString *)keyPath ascending:(BOOL)ascending;

// 防止数组越界的取值方式
- (id)objectAt:(NSUInteger)index;

@end
