//
//  NCTitleAttribute.h
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCTitleAttribute : NSObject

@property (nonatomic, strong) UIColor *titleColor;   // 标题颜色
@property (nonatomic, strong) UIFont  *titleFont;    // 标题字体

@property (nonatomic, strong) UIColor *shadowColor;  // 阴影颜色
@property (nonatomic, assign) CGSize   shadowOffset; // 阴影偏移量

// 将参数转换为字典
- (NSDictionary *)transformToDictionary;

@end
