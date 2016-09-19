//
//  NSString+CustomFont.m
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+CustomFont.h"
#import "FontInfo.h"

#ifdef DEBUG
#define NSStringCustomFontDLog(fmt, ...) NSLog((@"%@[%d]:%s:" fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __func__, ##__VA_ARGS__);
#else
#define NSStringCustomFontDLog(...)
#endif

@implementation NSString (CustomFont)

#pragma public

- (NSString *)customFontFamilyName
{
    return [self fontFamilyName:self customFontIndex:0];
}

- (NSString *)customFontFamilyNameAtIndex:(NSInteger)index
{
    return [self fontFamilyName:self customFontIndex:index];
}

- (NSArray *)customFontInfo
{
    NSDictionary *fontDic = [FontInfo customFontNameList];
    if (self) {
        return fontDic[self];
    } else {
        return nil;
    }
}

- (NSString *)systemFontFamilyName
{
    return [self fontFamilyName:self systemFontIndex:0];
}

- (NSString *)systemFontFamilyNameIndex:(NSInteger)index
{
    return [self fontFamilyName:self systemFontIndex:index];
}

- (NSArray *)systemFontInfo
{
    NSDictionary *fontDic = [FontInfo systomFontNameList];
    if (self) {
        return fontDic[self];
    } else {
        return nil;
    }
}

#pragma private
- (NSString *)fontFamilyName:(NSString *)fontName customFontIndex:(NSInteger)index
{
    if (fontName == nil) {
        return nil;
    }
    
    NSDictionary *fontDic = [FontInfo customFontNameList];
    NSArray *fontIndex = fontDic[fontName];
    
    if (fontIndex) {
        return fontIndex[index];
    } else {
        return nil;
    }
}

- (NSString *)fontFamilyName:(NSString *)fontName systemFontIndex:(NSInteger)index
{
    if (fontName == nil) {
        return nil;
    }
    
    NSDictionary *fontDic = [FontInfo systomFontNameList];
    NSArray *fontIndex = fontDic[fontName];
    
    if (fontIndex) {
        return fontIndex[index];
    } else {
        return nil;
    }
}

@end
