//
//  NSString+Appending.h
//  PM2.5
//
//  Created by YouXianMing on 14/11/18.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IsNum(A)  isNumText(A)


static inline BOOL isNumText(NSString * str){
    //    NSString * regex        = @"(/^[0-9]*$/)";
    //    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    BOOL isMatch            = [pred evaluateWithObject:str];
    //    if (isMatch) {
    //        return YES;
    //    }else{
    //        return NO;
    //    }
    
    
    
    if ([str isKindOfClass:[NSString class]] && str.length > 0) {
    
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    }else
    {
        return NO ;
    }
}

@interface NSString (Appending)

/**
 *  追加字符串
 *
 *  @param string 被最加的字符串
 */
- (NSString *)add:(NSString *)string;
- (BOOL)containsOtherString:(NSString *)string ;
- (BOOL)isMobileNumber ;

//- (BOOL)isPureInt:(NSString*)string{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    int val;
//    return[scan scanInt:&val] && [scan isAtEnd];
//}


@end
