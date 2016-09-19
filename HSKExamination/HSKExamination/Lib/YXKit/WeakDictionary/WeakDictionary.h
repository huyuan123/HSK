//
//  WeakDictionary.h
//  弱引用字典
//
//  http://www.cnblogs.com/YouXianMing/
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_WEAK_OBJECT(key)                 [WeakDictionary objectForKey:(key)]
#define REGISTER_WEAK_OBJECT(object, key)    [WeakDictionary addObject:(object) forKey:(key)]

@interface WeakDictionary : NSObject

+ (void)addObject:(id)object forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;

@end
