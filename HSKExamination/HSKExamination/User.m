//
//  User.m
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "User.h"

@implementation User
+ (id)shareInstance
{
    static User * u = nil ;
    static dispatch_once_t pre ;
    dispatch_once(&pre, ^{
        u = [[User alloc] init];
    }) ;
    
    return u ;
}

@end
