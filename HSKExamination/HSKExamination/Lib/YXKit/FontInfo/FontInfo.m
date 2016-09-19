//
//  FontInfo.m
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "FontInfo.h"
#import "UIFont+WDCustomLoader.h"

static NSMutableDictionary   *customFontDictionary = nil; // 自己加载的字体信息
static NSMutableDictionary   *systemFontDictionary = nil; // 系统字体信息

@implementation FontInfo

+ (void)initialize
{
    if (self == [FontInfo class])
    {
        customFontDictionary = [[NSMutableDictionary alloc] init];
        systemFontDictionary = [[NSMutableDictionary alloc] init];
        
        // 获取系统字体族
        [FontInfo getSystemFontList];
    }
}

+ (void)getSystemFontList
{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [systemFontDictionary setObject:fontNames forKey:familyName];
    }
}

+ (void)registerFont:(NSString *)fontPath withName:(NSString *)name
{
    NSArray *nameArray = [UIFont registerFontFromURL:[NSURL fileURLWithPath:fontPath]];
    [customFontDictionary setObject:nameArray forKey:name];
}

+ (NSDictionary *)customFontNameList
{
    return [NSDictionary dictionaryWithDictionary:customFontDictionary];
}

+ (NSDictionary *)systomFontNameList
{
    return [NSDictionary dictionaryWithDictionary:systemFontDictionary];
}

@end
