//
//  TestCenter.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TestCenter.h"

@implementation TestCenter

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _centerId = value ;
        
        return ;
    }
    
    [super setValue:value forKey:key];
}

@end
