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


@end
