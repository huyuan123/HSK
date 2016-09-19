//
//  NSObject+WeakDictionary.h
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeakDictionary.h"

// 取出弱字典中的存储的对象
static inline  id weakDictionaryObjectForKey(NSString *key)
{
    return [WeakDictionary objectForKey:key];
}


@interface NSObject (WeakDictionary)

// 将对象存储到弱字典当中(可以在NSString+WeakDictionary中取出对象)
- (void)storeToWeakDictionaryWithKey:(NSString *)key;

@end
