//
//  NSString+NetString.h
//  PM2.5
//
//  Created by YouXianMing on 14/11/18.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NetString)

/**
 *  转换成网络的UTF8String字符串
 *
 *  @return 转换后的字符串
 */
- (NSString *)toNetUTF8String;

@end
