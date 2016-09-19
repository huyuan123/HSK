//
//  NCTitleAttribute.m
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NCTitleAttribute.h"

@implementation NCTitleAttribute

- (NSDictionary *)transformToDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    if (_titleColor)
    {
        [dic setObject:_titleColor forKey:NSForegroundColorAttributeName];
    }
    else
    {
        [dic setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    }
    
    if (_titleFont)
    {
        [dic setObject:_titleFont forKey:NSFontAttributeName];
    }
    
    if (_shadowOffset.height && _shadowOffset.width)
    {
        NSShadow *shadow = [NSShadow new];
        
        shadow.shadowColor  = _shadowColor;
        shadow.shadowOffset = _shadowOffset;
        
        [dic setObject:shadow forKey:NSShadowAttributeName];
    }
    
    return dic;
}

@end
