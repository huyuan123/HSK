//
//  Candidates.m
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "Candidates.h"

@implementation Candidates

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if([key isEqualToString:@"id"]) {
//        self.productID = value;
//    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
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


@end