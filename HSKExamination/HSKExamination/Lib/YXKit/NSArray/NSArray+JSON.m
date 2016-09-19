//
//  NSArray+JSON.m
//  Category
//
//  Created by YouXianMing on 15-2-09.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

- (NSString *)toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)toReadableJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSData *)toJSONData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    return data;
}


- (NSArray *)createWithModelClassName:(NSString *)classname
{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.count] ;
    for (NSDictionary * dic in self) {
    id  model =    [[NSClassFromString(classname) alloc] initWithDictionary:dic];
        [array addObject:model];
//        NSLog(@"%@--------",dic[@"level"]) ;

    }
    
    
    return array ;
}


@end
