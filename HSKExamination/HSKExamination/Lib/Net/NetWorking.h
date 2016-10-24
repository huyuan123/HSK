//
//  NetWorking.h
//  HSKExamination
//
//  Created by printer on 9/19/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NetWorking : NSObject
+ (void)getWithUrl:(nonnull NSString *)urlString andSuccess:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable respos))success
           failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure ;

+ (void)postWithUrl:(nonnull NSString *)urlS andParameter:(nullable NSDictionary *)para andSuccess:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable respon))success
            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure ;

+ (void)downLoadWithUrl:(nonnull NSString *)urlString  completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *  error))completionHandler ;


+ (id)resoveData:(id)data ;
@end
