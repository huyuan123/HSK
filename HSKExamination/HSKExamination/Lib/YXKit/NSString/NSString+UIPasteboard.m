//
//  NSString+UIPasteboard.m
//  New
//
//  Created by YouXianMing on 14-9-22.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+UIPasteboard.h"
@implementation NSString (UIPasteboard)

- (BOOL)copyToUIPasteboard
{
    BOOL sucess = NO;
    
    if (self != nil) {
        sucess = YES;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self];
    }
    
    return sucess;
}

@end
