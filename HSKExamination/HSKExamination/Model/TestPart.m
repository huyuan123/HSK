//
//  testPart.m
//  HSKExamination
//
//  Created by printer on 9/8/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "testPart.h"

@implementation TestPart
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if([key isEqualToString:@"id"]) {
    //        self.productID = value;
    //    }
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
@end