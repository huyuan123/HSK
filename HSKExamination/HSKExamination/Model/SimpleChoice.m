//
//  SimpleChoice.m
//  HSKExamination
//
//  Created by hiddy on 16/10/2.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SimpleChoice.h"

@implementation SimpleChoice
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        _pinYInString = _textString = @"" ;
    }
    
    return self ;
}

- (id)init
{
    self = [super init];
    if (self) {
        _pinYInString = _textString = @"" ;
    }
    
    return self ;
}

@end
