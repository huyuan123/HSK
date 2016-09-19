//
//  UIButton+Init.h
//  PM2.5
//
//  Created by YouXianMing on 14/10/21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Init)

@property (nonatomic ,strong) NSString * titleString ;

- (void)addNormalTarget:(id)target action:(SEL)action ;

- (void)setHighlightedImage:(UIImage *)image;
- (UIImage *)highlightedImage;

- (void)setNormalImage:(UIImage *)image;
- (UIImage *)normalImage;

- (void)setSelectedImage:(UIImage *)image;
- (UIImage *)selectedImage;



@end
