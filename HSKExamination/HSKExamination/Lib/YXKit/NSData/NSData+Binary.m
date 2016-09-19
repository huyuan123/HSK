//
//  NSData+Binary.m
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSData+Binary.h"

@implementation NSData (Binary)

- (NSString *)transformToVisibleString
{
    if (self)
    {
        NSString* strRet = @"";
        char* pBuff = (char*)[self bytes];
        
        for (int i=0; i<self.length; i++)
        {
            strRet = [strRet stringByAppendingFormat:@"%02X", pBuff[i] & 0xFF];
        }
        
        return strRet;
    }
    else
    {
        return nil;
    }
}

@end
