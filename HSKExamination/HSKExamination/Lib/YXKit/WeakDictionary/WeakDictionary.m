//
//  WeakDictionary.m
//  弱引用字典
//
//  http://www.cnblogs.com/YouXianMing/
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "WeakDictionary.h"

static NSMapTable  *weakDictionary = nil;

@implementation WeakDictionary

+ (void)initialize
{
    if (self == [WeakDictionary class])
    {
        // 强引用key值弱引用object
        weakDictionary = [NSMapTable strongToWeakObjectsMapTable];
    }
}

+ (void)addObject:(id)object forKey:(NSString *)key
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

+ (id)objectForKey:(NSString *)key
{
    return [weakDictionary objectForKey:key];
}

@end
