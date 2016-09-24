//
//  UIFont+Adaptation.m
//  MyChild_teacher
//
//  Created by hu.yuan on 15/5/14.
//  Copyright (c) 2015年 hu.yuan. All rights reserved.
//

#import "UIFont+Adaptation.h"

@implementation UIFont (Adaptation)
+ (UIFont *)fontWithSizeAdaptation:(int)num
{
    return [UIFont systemFontOfSize:num];
}

@end
