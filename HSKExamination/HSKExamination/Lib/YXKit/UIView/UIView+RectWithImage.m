//
//  UIView+RectWithImage.m
//  TestPch
//
//  Created by YouXianMing on 14-9-26.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+RectWithImage.h"

@implementation UIView (RectWithImage)

- (void)resetSizeWithImage:(UIImage *)image scale:(CGFloat)value
{
    if (self && image) {
        CGRect rect = self.frame;
        rect.size = CGSizeMake(image.size.width * value, image.size.height * value);
        self.frame = rect;
    }
}

- (void)resetSizeWithImageSize:(CGSize)imageSize scale:(CGFloat)value
{
    if (self) {
        CGRect rect = self.frame;
        rect.size = CGSizeMake(imageSize.width * value, imageSize.height * value);
        self.frame = rect;
    }
}

- (void)resetSizeWithImage:(UIImage *)image widthScale:(CGFloat)widthScaleValue heightScale:(CGFloat)heightScaleValue
{
    if (self && image) {
        CGRect rect = self.frame;
        rect.size = CGSizeMake(image.size.width * widthScaleValue, image.size.height * heightScaleValue);
        self.frame = rect;
    }
}

- (void)resetSizeWithImageSize:(CGSize)imageSize widthScale:(CGFloat)widthScaleValue heightScale:(CGFloat)heightScaleValue
{
    if (self) {
        CGRect rect = self.frame;
        rect.size = CGSizeMake(imageSize.width * widthScaleValue, imageSize.height * heightScaleValue);
        self.frame = rect;
    }
}

@end
