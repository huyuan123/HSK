//
//  NETWorkPicUpload.h
//  UploadPics
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if 0

// 配置
NSString *urlString = @"http://trainddtestapi.tidoo.cn/courses/addReviewlevel.do";

NETWorkRequest *request = [[NETWorkRequest alloc] initWithUrlString:urlString];
[request configRequest:^(NSMutableURLRequest *request) {
    
    NSDictionary *dic = @{@"appkey"    :@"peixunduoduo",
                          @"content"   :@"验证最后一遍",
                          @"courseid"  :@"642",
                          @"fromapp"   :@"2",
                          @"sign"      :@"003a0d94aff1c7728ab21eb785fbd544",
                          @"sumscore"  :@"5",
                          @"timestamp" :@"1404373862",
                          @"userid"    :@"101"};
    
    UIImage *image1 = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"3"];
    
    NETWorkPicUpload *picUpload = [NETWorkPicUpload new];
    picUpload.parameters        = dic;
    picUpload.boundary          = @"AaB03x";
    picUpload.pictures          = @[createPNGPicture(@"AaB03x", image1, @"image1", @"1.png"),
                                    createPNGPicture(@"AaB03x", image2, @"image2", @"2.png"),
                                    createPNGPicture(@"AaB03x", image3, @"image3", @"3.png")];
    [picUpload configRequest:&request];
}];

// 请求
NETWorkConnection *connection = [[NETWorkConnection alloc] initWithRequest:request];
[connection infoBlock:^(NSDictionary *info) {
    NSLog(@"%@", info);
} progressBlock:^(long long currentBytes, long long totalBytes) {
} resultBlock:^(NSDictionary *info, NSData *data, NSError *error) {
    NSString *result = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
}];
[connection start];

#endif

// 创建pictures数组需要的数据 -- PNG类型
NSData * createPNGPicture(NSString *formBoundary,  UIImage  *image,
                          NSString *name,          NSString *filename);

// 创建pictures数组需要的数据 -- JPEG类型
NSData * createJPEGPicture(NSString *formBoundary, UIImage  *image,
                           NSString *name,         NSString *filename);

// 创建pictures数组需要的数据 -- GIF类型
NSData * createGifPicture(NSString *formBoundary,  NSData   *gifData,
                          NSString *name,          NSString *filename);

@interface NETWorkPicUpload : NSObject

@property (nonatomic, strong) NSString       *boundary;    // 分割字符串
@property (nonatomic, strong) NSDictionary   *parameters;  // 携带的参数
@property (nonatomic, strong) NSArray        *pictures;    // 封装好的图片的数据

- (void)configRequest:(NSMutableURLRequest **)request;

@end
