//
//  Tools.h
//  USA
//
//  Created by 永来 付 on 14/11/24.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Tools : NSObject

+ (void)alertViewShow:(NSString *)message;
//计算label的位置以及大小
+ (CGRect)labelFrameForString:(UILabel*)label;

//获取当前时间字符串
+ (NSString*)getCurrentTimeString;

//获取当前时间
+ (NSString*)currentTimeString ;

+ (void)clearDisk ;

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;

//获取版本
+ (NSString*)getApplicationVersion;

//收起键盘
+ (void)hiddenKeyboard;


// 显示提示框
+ (void) showHUD:(NSString*)text;

+ (MBProgressHUD*)showProgressWithTitle:(NSString*)title;
+ (void)hiddenProgress:(MBProgressHUD*)progress;
+ (NSString *)userIconpath ;

//返回分割线
+ (UIImageView*)createLine;

+ (BOOL)saveIconImage:(UIImage *)image ;
@end

@interface UIColor (Color16ToRgb)
+ (UIColor *)colorWithHexString: (NSString *)color;
@end



#pragma mark - UIImage+ResizableImage
@interface UIImage (ResizableImageAndNoCashedImage)

-(UIImage*)resizedImageWithCapInsets:(UIEdgeInsets)capInsets;

-(UIImage*)scaleToSize:(CGSize)size;

- (void)writeToalbum ;

@end

@interface UIButton (SetBackgroundImage)

- (void)setBackgroundSmallImageNor:(UIImage*)norImage smallImagePre:(UIImage*)preImage;

@end


@interface NSString (size)
- (CGSize)sizeForFont:(UIFont *)font andSize:(CGSize)size ;
@end
