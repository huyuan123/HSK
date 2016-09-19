//
//  UIView+RectWithImage.h
//  TestPch
//
//  Created by YouXianMing on 14-9-26.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RectWithImage)

// 不移动orgin的前提下重新设置该view的size值,且带有缩放比例
- (void)resetSizeWithImage:(UIImage *)image scale:(CGFloat)value;
- (void)resetSizeWithImageSize:(CGSize)imageSize scale:(CGFloat)value;

// 不移动orgin的前提下重新设置该view的size值,且带有缩放比例,单独设置宽度与高度
- (void)resetSizeWithImage:(UIImage *)image
                widthScale:(CGFloat)widthScaleValue
               heightScale:(CGFloat)heightScaleValue;
- (void)resetSizeWithImageSize:(CGSize)imageSize
                    widthScale:(CGFloat)widthScaleValue
                   heightScale:(CGFloat)heightScaleValue;

@end
