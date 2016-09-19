//
//  NETWorkRequest.m
//  NETWork
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "NETWorkRequest.h"

@interface NETWorkRequest ()

@end

@implementation NETWorkRequest

- (instancetype)init
{
    return [self initWithUrlString:nil];
}

- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self)
    {
        _request = [NSMutableURLRequest new];
        
        if (urlString)
        {
            _request.URL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

- (void)configRequest:(NETWorkRequestBlock)block
{
    block(self.request);
}

+ (instancetype)downloadFile:(NSString *)fileUrlString
{
    return [[NETWorkRequest alloc] initWithUrlString:fileUrlString];
}

@end
