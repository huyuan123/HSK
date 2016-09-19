//
//  UITableViewCell+Line.m
//  USA
//
//  Created by eric on 14-12-8.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import "UITableViewCell+Line.h"

@implementation UITableViewCell (Line)
- (void)addHeadLine
{
     UIView * lineView = [self viewWithTag:100];
    if (lineView) {
        lineView.hidden = NO ;
        return ;
    }
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, ScreenWidth, 0.5)];
    lineView.tag = 100 ;
    [self addSubview:lineView];
}

- (void)deleteHeadLine
{
    UIView * line = [self viewWithTag:100];
    line.hidden = YES ;
}

- (void)addFootLine
{
    UIView * lineView = [self viewWithTag:200];
    if (lineView) {
        lineView.hidden = NO ;
        return ;
    }
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, 0.5)];
    lineView.tag = 200 ;
    [self addSubview:lineView];
}

- (void)deleteFootLine
{
    UIView * line = [self viewWithTag:200];
    line.hidden = YES ;
}

- (void)setLineColor:(UIColor *)color
{
     UIView * head = [self viewWithTag:200];
     UIView * line = [self viewWithTag:100];
    head.backgroundColor = line.backgroundColor =  color ;
}
@end
