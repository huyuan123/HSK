//
//  NSString+Telephone.m
//  TelePhone
//
//  Created by YouXianMing on 14-9-23.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+Telephone.h"
#import <UIKit/UIApplication.h>

@implementation NSString (Telephone)

#pragma mark - public
- (BOOL)isMobileNumber
{
    return [self isMobileNumber:self];
}

- (void)phoneCall:(PhoneType)type
{
    // 如果有字符串
    if (self) {
        // 判断有没有电话功能
        if ([self isCallPhoneAvilable]) {
            // 手机
            if (type == TelePhone) {
                // 判断手机号是否合法
                if ([self isMobileNumber:self]) {
                    // 拨打电话
                    NSString * tele = [@"tel://" stringByAppendingString:self];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tele]];
                }
            }
            
            // 座机
            if (type == DesktopPhone) {
                // 拨打电话
                NSString * tele = [@"tel://" stringByAppendingString:self];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tele]];
            }
        }
    }
}

#pragma mark - pravite
/*
 是否有拨打电话功能
 @param       无
 @return      BOOL
 @exception   NO
 */
- (BOOL)isCallPhoneAvilable{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://"]];
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * G = @"^18[0-9]\\d{7,8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestg  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", G];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestg evaluateWithObject:mobileNum]) == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
