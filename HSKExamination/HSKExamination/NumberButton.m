//
//  NumberButton.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "NumberButton.h"

@implementation NumberButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = RGBCOLOR(133, 163, 54).CGColor ;
        self.layer.borderWidth = 1 ;
        self.cornerRadius = 5 ;
        [self setIsSelect:NO];
    }
    
    return self ;
}

- (void)setIsSelect:(BOOL)b
{
    if (b) {
        self.backgroundColor = RGBCOLOR(133, 163, 54) ;
        [self setTitleColor:[UIColor whiteColor] forState:BuNormal] ;
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:RGBCOLOR(133, 163, 54) forState:BuNormal] ;
    }
}

@end
