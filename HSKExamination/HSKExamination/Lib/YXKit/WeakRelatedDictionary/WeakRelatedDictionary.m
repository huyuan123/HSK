//
//  WeakRelatedDictionary.m
//  TestDemo
//
//  Created by YouXianMing on 14-9-25.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "WeakRelatedDictionary.h"

static NSMapTable  *weakDictionary = nil;

@implementation WeakRelatedDictionary

+ (void)initialize
{
    if (self == [WeakRelatedDictionary class])
    {
        // 弱引用object弱引用object
        weakDictionary = [NSMapTable weakToWeakObjectsMapTable];
    }
}

+ (void)addObject:(id)object forKey:(id)key
{
    if (object == nil || key == nil)
    {
        NSLog(@"object or key should not be nil.");
        return;
    }
    
    if ([weakDictionary objectForKey:key] == nil)
    {
        [weakDictionary setObject:object forKey:key];
    }
}

+ (id)objectForKey:(id)key
{
    return [weakDictionary objectForKey:key];
}

@end
