//
//  YXTimer.m
//  YXTimer
//
//  Created by YouXianMing on 14-10-2.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#ifdef DEBUG
#define YXTimer_DLog(fmt, ...) NSLog((@"YXTimer.m:%s:%d" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define YXTimer_DLog(...)
#endif

#import "YXTimer.h"

@interface YXTimer ()

@property (nonatomic) BOOL isRunning;
@property (nonatomic, copy) void (^block)(YXTimer *timer);

@end

@implementation YXTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isRunning = NO;
    }
    return self;
}

- (instancetype)initWithBlock:(void (^)(YXTimer *timer))block {
    self = [super init];
    
    if (self) {
        _isRunning = NO;
        _block     = block;
    }
    
    return self;
}

- (void)start {
    _isRunning = YES;
    [self runTimer];
}

- (void)stop {
    _isRunning = NO;
}

+ (instancetype)timerWithMilliSecondInterval:(NSTimeInterval)milliSecond
                                       Block:(void (^)(YXTimer *timer))block {
    YXTimer *timer = [[YXTimer alloc] initWithBlock:block];
    timer.milliSecond = milliSecond;
    
    return timer;
}

- (void)runTimer {
    
    if (self.isRunning) {
        
        NSTimeInterval  milliSecond = 1000.f;
        if (_milliSecond > 0) {
            milliSecond = _milliSecond;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(milliSecond * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            if (self.block) {
                self.block(self);
            }
            
            if (_delegate) {
                [_delegate YXTimerEvent:self];
            }
            
            [self runTimer];
        });
    }
}

- (void)dealloc {
    [self stop];
    YXTimer_DLog(@"资源释放了");
}

@end
