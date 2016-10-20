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

+ (void)playWithCorOrFalse:(BOOL)b
{
    //1.获得音效文件的全路径
    
    NSURL *url=  nil ;
    
    SystemSoundID soundID=0;

    if (b) {
        url =    [[NSBundle mainBundle]URLForResource:@"答对.aiff" withExtension:nil];
        soundID = 520 ;
    }else
    {
        soundID = 521 ;
        url = [[NSBundle mainBundle]URLForResource:@"答错.aiff" withExtension:nil];
    }
   
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //把需要销毁的音效文件的ID传递给它既可销毁
    //AudioServicesDisposeSystemSoundID(soundID);
    
    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
//    AudioServicesPlayAlertSound(soundID);
    AudioServicesPlaySystemSound(soundID) ;
}


@end
