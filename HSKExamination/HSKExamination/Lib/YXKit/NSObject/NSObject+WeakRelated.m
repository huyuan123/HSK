//
//  NSObject+WeakRelated.m
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSObject+WeakRelated.h"
#import "WeakRelatedDictionary.h"

@implementation NSObject (WeakRelated)

- (void)setRelatedObject:(id)object
{
    [WeakRelatedDictionary addObject:object forKey:self];
}

- (id)relatedObject
{
    return [WeakRelatedDictionary objectForKey:self];
}

@end
