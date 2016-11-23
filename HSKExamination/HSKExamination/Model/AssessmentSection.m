//
//  AssessmentSection.m
//  HSKExamination
//
//  Created by printer on 9/12/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AssessmentSection.h"

@implementation AssessmentSection

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
        _rubricBlock = @"" ;
    }
        
    return self;
}

- (void)setRubricMedia:(Media *)rubricMedia
{
    _rubricMedia = rubricMedia ;
    _rubricMedia.srcType = testPart ;
}
@end
