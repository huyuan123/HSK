//
//  NETWorkRequest.h
//  NETWork
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

// block的相关定义
typedef void (^NETWorkRequestBlock)(NSMutableURLRequest *request);


@interface NETWorkRequest : NSObject

@property (nonatomic, strong, readonly) NSMutableURLRequest *request;

- (instancetype)initWithUrlString:(NSString *)urlString;
+ (instancetype)downloadFile:(NSString *)fileUrlString;

- (void)configRequest:(NETWorkRequestBlock)block;

@end
