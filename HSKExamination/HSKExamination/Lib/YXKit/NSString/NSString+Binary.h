//
//  NSString+Binary.h
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Binary)

// 将字符串转换成不可识别二进制文件
- (NSData *)transformToBinaryData;

@end
