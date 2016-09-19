//
//  NSString+Binary.m
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+Binary.h"

@implementation NSString (Binary)

- (NSData *)transformToBinaryData
{
    if (self)
    {
        // 将字符串转换成不可识别二进制文件
        static unsigned char _map_ch2hex[] =
        {
            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
            0, 0, 0, 0, 0, 0, 0,    // :, ;, <, =, >, ?, @,
            0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
        };
        
        unsigned char* bytes = (unsigned char*)malloc((self.length + 1) * sizeof(unsigned char));
        [[self uppercaseString] getCString:(char*)bytes
                                 maxLength:self.length + 1
                                  encoding:NSUTF8StringEncoding];
        
        unsigned char *p1 = bytes, *p2 = bytes;
        unsigned long n   = self.length / 2;
        for (int i = 0; i<n; i++)
        {
            *p1 = _map_ch2hex[*p2-'0'] * 0x10 + _map_ch2hex[*(p2+1)-'0'];
            p1++;
            p2 += 2;
        }
        
        NSData* toData = [NSData dataWithBytes:bytes length:n];
        return toData;
    }
    else
    {
        return nil;
    }
}

@end
