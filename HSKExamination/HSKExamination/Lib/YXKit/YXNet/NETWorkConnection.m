//
//  NETWorkConnection.m
//  NETWork
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "NETWorkConnection.h"
#import "NETWorkRequest.h"
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define NETWorkConnection_DLog(fmt, ...) NSLog((@"%@[%d]:%s:" fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __func__, ##__VA_ARGS__);
#else
#define NETWorkConnection_DLog(...)
#endif

// 获取联网提示
static UIApplication *_application = nil;

@interface NETWorkConnection ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, copy)   NETWorkConnectionBlock  onncetionBlock;   // 网络连接用block
@property (nonatomic, copy)   NETWorkInfoBlock        infoBlock;        // 信息block
@property (nonatomic, copy)   NETWorkProgressBlock    progressBlock;    // 进度block
@property (nonatomic, assign) unsigned long long      expectedLength;   // 从服务器获取期望文件的大小

@property (nonatomic, strong) NSURLConnection        *conncetion;       // 网络连接
@property (nonatomic, strong) NSMutableData          *cacheData;        // 用于缓存的data数据
@property (nonatomic, strong) NSMutableDictionary    *info;             // 一些链接的信息

@end

@implementation NETWorkConnection

+ (void)initialize
{
    if (self == [NETWorkConnection class])
    {
        // 获取到网络显示标签
        _application = [UIApplication sharedApplication];
    }
}

- (instancetype)initWithRequest:(NETWorkRequest *)request
{
    self = [super init];
    if (self)
    {
        // 开始创建连接
        _conncetion = \
        [[NSURLConnection alloc] initWithRequest:request.request
                                        delegate:self
                                startImmediately:NO];
        
        // 创建数据容器
        _cacheData = [NSMutableData data];
        
        // 储存一些信息
        _info = [NSMutableDictionary new];
        
        // 期望数据
        _expectedLength = 0;
    }
    return self;
}

- (void)start
{
    // 显示联网提示
    if (_showNetworkActivityIndicator == YES) {
        [_application setNetworkActivityIndicatorVisible:YES];
    }
    
    // 开始联网
    [self.conncetion start];
}

- (void)cancel
{
    // 显示联网提示
    if (_showNetworkActivityIndicator == YES) {
        [_application setNetworkActivityIndicatorVisible:NO];
    }
    
    /* After this method is called, the connection’s delegate no longer
     receives any messages for the connection. If you want to reattempt
     the connection, you should create a new connection object. */
    [_conncetion cancel];
}

#pragma mark - delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    __weak NETWorkConnection *weakConnection = self;
    
    // 存储一些网络回复的信息
    [_info setObject:@(response.expectedContentLength) forKey:@"expectedContentLength"];
    if (response.suggestedFilename)
        [_info setObject:response.suggestedFilename forKey:@"suggestedFilename"];
    if (response.MIMEType)
        [_info setObject:response.MIMEType          forKey:@"MIMEType"];
    if (response.textEncodingName)
        [_info setObject:response.textEncodingName  forKey:@"textEncodingName"];
    if (response.URL.description)
        [_info setObject:response.URL.description   forKey:@"URL"];
    
    // 走HTTP协议的网络链接会执行括号类的方法
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
        
        [_info setObject:r.allHeaderFields forKey:@"allHeaderFields"];
        [_info setObject:@(r.statusCode)   forKey:@"statusCode"];
        
        // 如果能获取到期望的数据长度就执行括号中的方法
        if ([r expectedContentLength] != NSURLResponseUnknownLength)
        {
            // 获取期望下载的数值
            _expectedLength  = [r expectedContentLength];
        }
    }
    
    // 如果存在block则执行
    if (_infoBlock)
    {
        _infoBlock(_info, weakConnection);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    __weak NETWorkConnection *weakConnection = self;
    
    // 存储缓存数据
    [_cacheData appendData:theData];
    
    // 如果存在block则执行
    if (_progressBlock)
    {
        // 调用block
        _progressBlock(_cacheData.length, _expectedLength, weakConnection);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    __weak NETWorkConnection *weakConnection = self;
    
    // 显示联网提示
    if (_showNetworkActivityIndicator == YES) {
        [_application setNetworkActivityIndicatorVisible:NO];
    }
    
    // 如果存在block则执行
    if (_onncetionBlock)
    {
        // 调用block
        _onncetionBlock(_info, _cacheData, nil, weakConnection);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    __weak NETWorkConnection *weakConnection = self;
    
    // 显示联网提示
    if (_showNetworkActivityIndicator == YES) {
        [_application setNetworkActivityIndicatorVisible:NO];
    }
    
    // 如果存在block则执行
    if (_onncetionBlock)
    {
        // 调用block
        _onncetionBlock(_info, nil, error, weakConnection);
    }
}

#pragma mark - 核心,初始化所有的block
- (void)infoBlock:(NETWorkInfoBlock)infoBlock
    progressBlock:(NETWorkProgressBlock)progressBlock
      resultBlock:(NETWorkConnectionBlock)connectionBlock
{
    __weak NETWorkConnection *weakConnection = self;
    
    // 初始化回复信息block
    _infoBlock = ^(NSDictionary *info, NETWorkConnection *connection)
    {
        infoBlock(info, weakConnection);
    };
    

    // 初始化进度的block
    _progressBlock = ^(long long currentBytes, long long totalBytes, NETWorkConnection *connection)
    {
        progressBlock(currentBytes, totalBytes, weakConnection);
    };
    
    
    // 初始化链接结果的block
    _onncetionBlock = ^(NSDictionary *info, NSData *data, NSError *error, NETWorkConnection *connection)
    {
        connectionBlock(info, data, error, weakConnection);
    };
}

- (void)dealloc
{
    NETWorkConnection_DLog(@"网络资源成功释放");
}

@end
