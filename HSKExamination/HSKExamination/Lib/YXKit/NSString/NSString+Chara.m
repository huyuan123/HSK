//
//  NSString+Chara.m
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "NSString+Chara.h"

@implementation NSString (Chara)
- (BOOL)isCharacter
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:self] == YES)
        return YES;
    else
        return NO;
}

- (BOOL)isNumber
{
//    NSLog(@"===================%@",self) ;
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isChinese
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [self getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;

}

- (NSString *)isContainNum
{
    if (self.length == 1 && [self isNumber]) {
        return self ;
    }else
    {
        for (int i = 0; i < self.length; i++) {
            NSString * s = [self substringWithRange:NSMakeRange(i, 1)];
            if (s.isNumber) {
                return s ;
            }
        }
        
        return nil ;
    }
}

- (NSString *)isContainCharater
{
    if (self.length == 1 && [self isCharacter]) {
        return self ;
    }else
    {
        for (int i = 0; i < self.length; i++) {
            NSString * s = [self substringWithRange:NSMakeRange(i, 1)];
            if (s.isCharacter) {
                return s ;
            }
        }
        
        return nil ;
    }
}



@end
