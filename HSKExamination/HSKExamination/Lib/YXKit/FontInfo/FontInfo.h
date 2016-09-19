//
//  FontInfo.h
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontInfo : NSObject

+ (NSDictionary *)customFontNameList;
+ (NSDictionary *)systomFontNameList;
+ (void)registerFont:(NSString *)fontPath withName:(NSString *)name;

@end
