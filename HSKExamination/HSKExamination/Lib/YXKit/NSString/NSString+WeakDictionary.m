//
//  NSString+WeakDictionary.m
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+WeakDictionary.h"
#import "WeakDictionary.h"

@implementation NSString (WeakDictionary)

- (id)recoverFromWeakDictionary
{
    return [WeakDictionary objectForKey:self];
}

@end
