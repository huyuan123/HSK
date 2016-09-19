//
//  NSString+NetString.m
//  PM2.5
//
//  Created by YouXianMing on 14/11/18.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+NetString.h"

@implementation NSString (NetString)

- (NSString *)toNetUTF8String {
    NSString *str = self;
    
    if (str) {
        str = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return str;
}

@end
