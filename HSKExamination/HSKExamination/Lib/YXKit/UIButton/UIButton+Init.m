//
//  UIButton+Init.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIButton+Init.h"

@implementation UIButton (Init)

- (void)setHighlightedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateSelected];
}

- (UIImage *)selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setNormalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setTitleString:(NSString *)string
{
    [self setTitle:string forState:UIControlStateNormal];
}

- (NSString *)titleString
{
    return self.titleLabel.text ;
}

- (void)addNormalTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


@end


