//
//  Img.m
//  HSKExamination
//
//  Created by printer on 9/26/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "Img.h"

@implementation Img
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
    
    NSFileManager * file = [NSFileManager defaultManager];

    if ([file fileExistsAtPath:[[User shareInstance].paperPath stringByAppendingPathComponent:@"AssessmentItems"]]) {

        NSString * path  = [[User shareInstance].paperPath stringByAppendingPathComponent:@"AssessmentItems"];
        
        _src = [path stringByAppendingPathComponent:_src] ;

    }else
    if ([file fileExistsAtPath:[[User shareInstance].paperPath stringByAppendingPathComponent:@"assessmentitems"]])
    {
        NSString * path  = [[User shareInstance].paperPath stringByAppendingPathComponent:@"assessmentitems"];
        
        _src = [path stringByAppendingPathComponent:_src] ;

    }
    
    if (!_height) {
        _height = @"100" ;
    }
    
    if (!_width) {
        _width = @"128" ;
    }
    
    if (_style) {
        _style = [_style stringByReplacingOccurrencesOfString:@"px" withString:@""];
        _style = [_style stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray * arr = [_style componentsSeparatedByString:@";"] ;
        
        NSString * height = [arr[0] componentsSeparatedByString:@":"][0] ;
        if ([height isEqualToString:@"height"]) {
            _height = [arr[0] componentsSeparatedByString:@":"][1] ;
            _width = [arr[1] componentsSeparatedByString:@":"][1] ;

        }else
        {
            _width = [arr[0] componentsSeparatedByString:@":"][1] ;
            _height = [arr[1] componentsSeparatedByString:@":"][1] ;

        }
        
    }
    
    return self;
}

//- (NSString *)src
//{
//    NSFileManager * file = [NSFileManager defaultManager];
//    if ([file fileExistsAtPath:_src]) {
//        return _src ;
//    }else
//    {
//        return [_src stringByReplacingOccurrencesOfString:@"AssessmentItems" withString:@"assessmentitems"];
//    }
//}

@end
