//
//  NSData+JSON.m
//  Category
//
//  Created by YouXianMing on 14-8-28.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)toPropertyList
{
    return [NSJSONSerialization JSONObjectWithData:self
                                           options:NSJSONReadingMutableLeaves
                                             error:nil];
}

@end
