//
//  UIView+Init.m
//  PM2.5
//
//  Created by YouXianMing on 14/10/21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIView+Init.h"

@implementation UIView (Init)

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag {
    UIView *tmp =  [self initWithFrame:frame];

    tmp.tag     = tag;
    
    return tmp;
}

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag insertInView:(UIView *)view {
    UIView *tmp = [self  initWithFrame:frame];
    tmp.tag     = tag;
    [view addSubview:tmp];
    
    return tmp;
}

- (instancetype)initWithFrame:(CGRect)frame insertInView:(UIView *)view {
    UIView *tmp = [self  initWithFrame:frame];
    [view addSubview:tmp];
    
    return tmp;
}


- (CGFloat)disTanceWithOtherView:(UIView *)view  //  计算此view和参数view的中心距离
{
    CGPoint p1 = self.center , p2 = view.center ;
    
    CGFloat dx = p1.x - p2.x  , dy = p1.y - p2.y ;
    
    return sqrt(dx*dx + dy*dy) ;
}
@end
