//
//  YXCrypto.m
//  用秘钥给字符串加密或者解密
//
//  Created by YouXian on 14-3-18.
//  Copyright (c) 2014年 YouXian. All rights reserved.
//

#import "YXCrypto.h"
#import <CommonCrypto/CommonCryptor.h>

#if __has_feature(objc_arc)
// ARC
#define Auto_Release(obj)
#define Safe_Release(obj)
#else
// 非ARC
#define Auto_Release(obj) [obj autorelease]
#define Safe_Release(obj) [obj release]; obj = nil
#endif

static YXCrypto *shareInstance = nil;

@implementation YXCrypto

/*!
 * 给字符串加密
 */
+ (NSString *)DesEncryptString:(NSString*)src WithKey:(NSString *)key {
    NSString* strRet = @"";
    
    if (shareInstance == nil)
    {
        shareInstance = [[YXCrypto alloc] init];
    }
    
    // encrypt source content
    NSData* bytes = [src dataUsingEncoding:NSUTF8StringEncoding];
    NSData* data = [shareInstance DesCryptWithOperation:kCCEncrypt
                                                  bytes:bytes
                                                    key:key];
    
    // format bytes to visible string
    char* pBuff = (char*)[data bytes];
    for (int i=0; i<data.length; i++) {
        strRet = [strRet stringByAppendingFormat:@"%02X", pBuff[i]& 0xFF];
    }
    return strRet;
}

/*!
 * 给字符串解密
 */
+ (NSString *)DesDecryptString:(NSString*)src WithKey:(NSString *)key
{
    if (shareInstance == nil)
    {
        shareInstance = [[YXCrypto alloc] init];
    }
    
    static unsigned char _map_ch2hex[] =
    {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
        0, 0, 0, 0, 0, 0, 0,    // :, ;, <, =, >, ?, @,
        0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    };
    
    // decode source content to bytes
    unsigned char* bytes = (unsigned char*)malloc((src.length+1)*sizeof(unsigned char));
    [[src uppercaseString] getCString:(char*)bytes maxLength:src.length+1 encoding:NSUTF8StringEncoding];
    unsigned char *p1 = bytes, *p2 = bytes;
    unsigned long n = src.length/2;
    for (int i=0; i<n; i++) {
        *p1 = _map_ch2hex[*p2-'0'] * 0x10 + _map_ch2hex[*(p2+1)-'0'];
        p1++;
        p2+=2;
    }
    NSData* data = [NSData dataWithBytes:bytes
                                  length:n];
    
    // decrypt source bytes
    NSData* dataOut = [shareInstance DesCryptWithOperation:kCCDecrypt
                                                     bytes:data
                                                       key:key];
    free(bytes);
    
    NSString* strRet = [[NSString alloc] initWithData:dataOut
                                             encoding:NSUTF8StringEncoding];
    Auto_Release(strRet);
    
    return strRet;
}

- (NSData *)DesCryptWithOperation:(CCOperation)operation bytes:(NSData*)bytes key:(NSString *)key {
    
    NSUInteger dataLength = [bytes length];
    
    size_t bufferSize = ([bytes length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char *buffer = (unsigned char *)malloc(bufferSize*sizeof(unsigned char));
    memset((void*)buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          (void const*)[key UTF8String],
                                          kCCKeySizeDES,
                                          NULL,
                                          [bytes bytes], dataLength,
                                          (void*)buffer, bufferSize,
                                          &numBytesCrypted);
    NSData* dataRet = nil;
    if (cryptStatus == kCCSuccess) {
        dataRet = [[NSData alloc] initWithBytes:buffer length:numBytesCrypted];
        Auto_Release(dataRet);
    }
    free(buffer);
    return dataRet;
}

@end
