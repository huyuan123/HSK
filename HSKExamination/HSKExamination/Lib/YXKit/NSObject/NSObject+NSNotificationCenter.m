//
//  NSObject+NSNotificationCenter.m
//  TouchImageView
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSObject+NSNotificationCenter.h"

@implementation NSObject (NSNotificationCenter)

- (void)registerNSNotificationCenterWithName:(NSString *)name selector:(SEL)sel
{
    // 注册通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:sel
                                                 name:name
                                               object:nil];
}

- (void)removeNSNotificationCenterWithName:(NSString *)name
{
    // 移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)postNotificationName:(NSString *)name userInfo:(NSDictionary *)dictionary
{
    if (self == nil) {
        return;
    }
    
    // 发送消息
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:self
                                                      userInfo:dictionary];
}

- (NSDictionary *)notificationUserInfo
{
    // 消息实体内容
    if ([self isKindOfClass:[NSNotification class]]) {
        NSNotification *tmp = (NSNotification *)self;
        return tmp.userInfo;
    }
    else {
        return nil;
    }
}

- (id)notificationObject
{
    // 消息实体内容
    if ([self isKindOfClass:[NSNotification class]]) {
        NSNotification *tmp = (NSNotification *)self;
        return tmp.object;
    }
    else {
        return nil;
    }
}

- (NSString *)notificationName
{
    // 消息实体内容
    if ([self isKindOfClass:[NSNotification class]]) {
        NSNotification *tmp = (NSNotification *)self;
        return tmp.name;
    }
    else {
        return nil;
    }
}


@end
