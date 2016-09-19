//
//  WeakRelatedDictionary.h
//  TestDemo
//
//  Created by YouXianMing on 14-9-25.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakRelatedDictionary : NSObject

+ (void)addObject:(id)object forKey:(id)key;
+ (id)objectForKey:(id)key;

@end
