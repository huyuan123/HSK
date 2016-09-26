//
//  ItemBu.m
//  HSKExamination
//
//  Created by hiddy on 16/9/26.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ItemBu.h"

@implementation ItemBu
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName ;
    [self setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"-nor"]] forState:BuNormal];
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
