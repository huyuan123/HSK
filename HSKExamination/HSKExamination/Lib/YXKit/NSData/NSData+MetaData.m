//
//  NSData+MetaData.m
//  PictureInfo
//
//  Created by YouXianMing on 14-8-27.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSData+MetaData.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@implementation NSData (MetaData)

- (NSDictionary *)imageMetaData
{
    if (self == nil)
    {
        return nil;
    }
    
    CGImageSourceRef source       = CGImageSourceCreateWithData((__bridge CFDataRef)self, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    CFRelease(source);
    
    NSDictionary *metaDataInfo    = CFBridgingRelease(imageMetaData);
    return metaDataInfo;
}

@end
