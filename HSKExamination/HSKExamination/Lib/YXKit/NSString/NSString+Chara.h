//
//  NSString+Chara.h
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chara)

- (BOOL)isCharacter ;

- (BOOL)isNumber ;

- (BOOL)isChinese ;

- (NSString *)isContainNum ;

- (NSString *)isContainCharater ;
@end
