//
//  RightBu.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RightBu.h"

@implementation RightBu
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = CenterText ;
    }
    return self ;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName ;
    [self setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"-nor"]] forState:BuNormal];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect r = self.frame ;
    return CGRectMake((r.size.width -31)/2, 0, 31, 31) ;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect r  = self.frame ;
    return CGRectMake(0, 33, r.size.width, 30) ;
}

- (void)setIsSelect:(BOOL)b
{
    if (b) {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"-pre"]] forState:BuNormal];
    }else
    {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"-nor"]] forState:BuNormal];
    
    }
}

@end
