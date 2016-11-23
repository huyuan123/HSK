//
//  assessmentItemRef.m
//  HSKExamination
//
//  Created by printer on 9/12/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AssessmentItemRef.h"

@implementation AssessmentItemRef
{
    NSString    *   _userChoice ;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//        if([key isEqualToString:@"href"]) {
//            _href = [value lowercaseString];
//        }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        
        //        NSLog(@"%@------%@",key,value);
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
    
    return self;
}

- (NSString *)userChoice
{
    if (_userChoice) {
        return _userChoice ;
    }
    
   NSDictionary * dic = [UserDefault objectForKey:UserResData];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic[_identifier] isKindOfClass:[NSString class]]) {
            return dic[_identifier];
        }
    }
    
    return nil ;
}

- (void)setUserChoice:(NSString *)userChoice
{
    if (isCanUseString(userChoice)) {
        _userChoice = userChoice ;
    }
}

- (NSMutableDictionary *)userResDic
{
    if (_userResDic) {
        return _userResDic ;
    }
    
    NSDictionary * dic = [UserDefault objectForKey:UserResData];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSDictionary * d =  dic[_identifier];
        if ([d isKindOfClass:[NSDictionary class]]) {
            return [NSMutableDictionary dictionaryWithDictionary:d];
        }
    }
    return nil ;
}
@end
