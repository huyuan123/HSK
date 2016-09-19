//
//  NSString+CustomFont.h
//  GCD
//
//  Created by YouXianMing on 14-9-21.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 经典字体家族
 "Helvetica Neue" =     (
 "HelveticaNeue-BoldItalic",
 "HelveticaNeue-Light",
 "HelveticaNeue-Italic",
 "HelveticaNeue-UltraLightItalic",
 "HelveticaNeue-CondensedBold",
 "HelveticaNeue-MediumItalic",
 "HelveticaNeue-Thin",
 "HelveticaNeue-Medium",
 "HelveticaNeue-ThinItalic",
 "HelveticaNeue-LightItalic",
 "HelveticaNeue-UltraLight",
 "HelveticaNeue-Bold",
 HelveticaNeue,
 "HelveticaNeue-CondensedBlack"
 );
 */

@interface NSString (CustomFont)

- (NSString *)customFontFamilyName;
- (NSString *)customFontFamilyNameAtIndex:(NSInteger)index;
- (NSArray *)customFontInfo;

- (NSString *)systemFontFamilyName;
- (NSString *)systemFontFamilyNameIndex:(NSInteger)index;
- (NSArray *)systemFontInfo;

@end
