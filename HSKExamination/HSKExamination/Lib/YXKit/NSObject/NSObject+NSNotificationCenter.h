//
//  NSObject+NSNotificationCenter.h
//  TouchImageView
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSNotificationCenter)

// 注册通知中心
- (void)registerNSNotificationCenterWithName:(NSString *)name selector:(SEL)sel;

// 移除通知中心
- (void)removeNSNotificationCenterWithName:(NSString *)name;

// 发送消息
- (void)postNotificationName:(NSString *)name userInfo:(NSDictionary *)dictionary;



// UserInfo
- (NSDictionary *)notificationUserInfo;

// object
- (id)notificationObject;

// string
- (NSString *)notificationName;

@end
