//
//  UIFont+Custom.m
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "UIFont+CustomFont.h"
#import "FontInfo.h"

#ifdef DEBUG
#define UIFontCustomFontDLog(fmt, ...) NSLog((@"%@[%d]:%s:" fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __func__, ##__VA_ARGS__);
#else
#define UIFontCustomFontDLog(...)
#endif

@implementation UIFont (CustomFont)

+ (void)registerFontFamily:(NSString *)fontPath withName:(NSString *)name
{
    if (fontPath == nil) {
        UIFontCustomFontDLog(@"[警告]fontPath为空");
        return;
    }
    
    [FontInfo registerFont:fontPath withName:name];
}

+ (NSDictionary *)systomAllFontsFamilyInfo
{
    return [FontInfo systomFontNameList];
}

@end
