//
//  HYDianxuanVIew.h
//  YueYi
//
//  Created by eric on 14-5-3.
//  Copyright (c) 2014年 hu.yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDianxuanVIew : UIView
@property (nonatomic ,assign) BOOL isDIanxuan ;
@property (nonatomic ,copy) void(^block)(BOOL isDIanxuan) ;
- (void)dianxuan ;
- (void)notDianxuan ;
@end
