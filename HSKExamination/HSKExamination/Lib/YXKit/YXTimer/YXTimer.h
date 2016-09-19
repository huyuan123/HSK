//
//  YXTimer.h
//  YXTimer
//
//  Created by YouXianMing on 14-10-2.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXTimer;

@protocol YXTimerDelegete <NSObject>
- (void)YXTimerEvent:(YXTimer *)timer;
@end

@interface YXTimer : NSObject

// 代理相关方法
@property (nonatomic) NSTimeInterval              milliSecond; // 毫秒
@property (nonatomic, assign) id<YXTimerDelegete> delegate;


// block相关方法
+ (instancetype)timerWithMilliSecondInterval:(NSTimeInterval)milliSecond
                                       Block:(void (^)(YXTimer *timer))block;

// 激活定时器 + 停止定时器
- (void)start;
- (void)stop; // 注意：要想让timer能被移除，一定要激活stop方法才行

@end
