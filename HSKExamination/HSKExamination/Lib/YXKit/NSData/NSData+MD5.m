//
//  NSData+MD5.m
//  Category
//
//  Created by YouXianMing on 14-8-30.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSData+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

+ (NSString *)MD5Hash:(NSData *)input
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input.bytes, (unsigned int)input.length, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)MD5HashLower:(BOOL)lower
{
    if (lower == YES)
    {
        return [NSData MD5Hash:self];
    }
    else
    {
        return [[NSData MD5Hash:self] uppercaseString];
    }
}

 - (NSString *)md5
{
    NSString * inPutText = (NSString *)self ;
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


@end