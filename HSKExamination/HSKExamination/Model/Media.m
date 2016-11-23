//
//  Media.m
//  HSKExamination
//
//  Created by printer on 9/26/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "Media.h"

@implementation Media
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
        if([key isEqualToString:@"src"]) {
            _src = [value lowercaseString];
        }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        
        [super setValue:@"" forKey:key] ;
        return;
    }
    
    [super setValue:value forKey:key];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        if ([dictionary isKindOfClass:[NSDictionary class]])
        {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    _srcType = judgeMent ;
    _src = [_src lowercaseString];
    return self;
}

- (NSString *)src
{
    switch (_srcType) {
        case judgeMent:
        {
            NSString * path = [[User shareInstance].paperPath stringByAppendingPathComponent:@"AssessmentItems"];
            
            return     [path stringByAppendingPathComponent:_src] ;

         
        }
            break;
            case testPart:
        {
        
            return [[User shareInstance].paperPath stringByAppendingString:_src] ;
            
        }
            break ;
        default:
            break;
    }
}

@end
