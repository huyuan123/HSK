//
//  User.m
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "User.h"
#import "Header.h"
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


+ (NSMutableDictionary *)dictionaryWithLevel:(int)level
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"level%d",level]];
    if (dic) {
        return [NSMutableDictionary dictionaryWithDictionary:dic] ;
    }else
    {
        return [NSMutableDictionary dictionary];
    }
}

+ (void)setStatisticsWithType:(NSString *)type andIScorrect:(BOOL)b
{
    NSMutableDictionary * dic= [self dictionaryWithLevel:[User shareInstance].level] ;
    NSDictionary * typeDic = dic[type];
    if (!typeDic) {
        typeDic = [NSMutableDictionary dictionary];
    }else
    {
        typeDic = [NSMutableDictionary dictionaryWithDictionary:typeDic];
    }
    
    int corr = [typeDic[corrCount] intValue];
    int all  = [typeDic[allCount] intValue];
    
    all ++ ;
    
    if (b) {
        corr ++ ;
    }
    

    [typeDic setValue:[NSString stringWithFormat:@"%d",all] forKey:allCount];
    [typeDic setValue:[NSString stringWithFormat:@"%d",corr] forKey:corrCount];
    
    [dic setObject:typeDic forKey:type];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"level%d",[User shareInstance].level]]; 

}

- (void)setSerVerConfig:(NSDictionary *)serVerConfig
{
    _serVerConfig = serVerConfig ;
    [[NSUserDefaults standardUserDefaults] setObject:serVerConfig forKey:SerVerConfig];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
