//
//  LeftSelectBu.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "LeftSelectBu.h"

@implementation LeftSelectBu
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName ;
    [super setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"未选"]] forState:BuNormal];
    [super setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"未选"]] forState:UIControlStateHighlighted];

    self.width = 60 ;
}

- (void)setIsSelect:(BOOL)b
{
    if (b) {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"点中"]] forState:BuNormal];
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"点中"]] forState:UIControlStateHighlighted];
        
        self.width = 90 ;
    }else
    {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"未选"]] forState:BuNormal];
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"未选"]] forState:UIControlStateHighlighted];
        
        self.width = 60 ;

    }
}

@end
