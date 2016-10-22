//
//  NetWorking.m
//  HSKExamination
//
//  Created by printer on 9/19/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "NetWorking.h"

@implementation NetWorking

+ (AFHTTPSessionManager *)getManger
{
    static AFHTTPSessionManager * manger = nil ;
    if (manger == nil) {
        manger = [AFHTTPSessionManager manager];
        manger.requestSerializer = [AFJSONRequestSerializer serializer];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        manger.responseSerializer.acceptableContentTypes = [manger.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        manger.responseSerializer.acceptableContentTypes = [manger.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
  
//        [manger.requestSerializer setValue:@"json" forHTTPHeaderField:@"datatype"];
//        [manger.requestSerializer setValue:@"json" forHTTPHeaderField:@"datatype"];

        manger.requestSerializer.timeoutInterval = 20 ;

    }
    
    
    return manger ;
}


+ (void)downLoadWithUrl:(NSString *)urlString  completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        NSLog(@"%@------------%@",targetPath,[response suggestedFilename]) ;
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
     
            NSLog(@"Error: %@", error);
            completionHandler( response, filePath, error) ;
        
    }];
    [downloadTask resume];
}

- (void)uoLoad
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

- (void)mutableDownLoad
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}


+ (void)getWithUrl:(NSString *)urlString andSuccess:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [self getManger];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             success(task,responseObject) ;
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             failure(task,error) ;
             
         }];
}


+ (void)postWithUrl:(NSString *)urlS andParameter:(NSDictionary *)para andSuccess:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
            failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    
//    AFJSONRequestSerializer
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = para;
    
    [manager POST:urlS parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(task,responseObject) ;
        
//        NSLog(@"%@",responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task ,error) ;
    }];
}

@end
