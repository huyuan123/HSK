//
//  NETWorkConnection.h
//  NETWork
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

//==============================================
// -注意-
// 网络资源,一旦start了之后就开启了线程,如果此时要关闭
// 网络链接,需要自己手动调用cancel才能够终止线程,这一
// 点是相当重要的.
//==============================================

#import <Foundation/Foundation.h>
@class NETWorkRequest;
@class NETWorkConnection;

// block的相关定义(作为隐藏属性,对外不可见)
typedef void (^NETWorkConnectionBlock)(NSDictionary *info, NSData *data, NSError *error, NETWorkConnection *myConnection);
typedef void (^NETWorkInfoBlock)(NSDictionary *info, NETWorkConnection *myConnection);
typedef void (^NETWorkProgressBlock)(long long currentBytes, long long totalBytes, NETWorkConnection *myConnection);

@interface NETWorkConnection : NSObject

@property (nonatomic, strong, readonly) NETWorkRequest  *request;
@property (nonatomic, assign, setter=isShowNetworkActivityIndicator:) BOOL showNetworkActivityIndicator;  // 是否显示网络旋转的标示

// 初始化
- (instancetype)initWithRequest:(NETWorkRequest *)request;

// 配置
- (void)infoBlock:(NETWorkInfoBlock)infoBlock               // 显示服务器返回的信息
    progressBlock:(NETWorkProgressBlock)progressBlock       // 显示下载进度
      resultBlock:(NETWorkConnectionBlock)connectionBlock;  // 获取最后得到的数据

// 开始链接
- (void)start;

// 取消链接
- (void)cancel;

@end
