//
//  UIImage+MetaData.h
//  PictureInfo
//
//  Created by YouXianMing on 14-8-27.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MetaData)

// 获取JPEG图片元数据
- (NSDictionary *)JPEGmetaData;

// 获取PNG图片元数据
- (NSDictionary *)PNGmetaData;
- (UIImage *)fixOrientation ;
@end
