//
//  NSString+Telephone.h
//  TelePhone
//
//  Created by YouXianMing on 14-9-23.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TelePhone = 0x88,  // 手机
    DesktopPhone,      // 座机
} PhoneType;

@interface NSString (Telephone)

// 是否是合法的手机号码
- (BOOL)isMobileNumber;

// 直接拨打电话
- (void)phoneCall:(PhoneType)type;

@end
