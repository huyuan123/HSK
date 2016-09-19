//
//  NSObject+WeakDictionary.m
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSObject+WeakDictionary.h"

@implementation NSObject (WeakDictionary)

- (void)storeToWeakDictionaryWithKey:(NSString *)key
{
    [WeakDictionary addObject:self forKey:key];
}

@end
