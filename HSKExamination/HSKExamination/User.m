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

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model ;
{
    BOOL b = NO ; ;

    if (isCanUseString(model.correctResponse) && isCanUseString(model.userChoice)) {
        b = [model.correctResponse isEqualToString:model.userChoice];
    }
    
    [self loadIsCorrect:b andRef:model];
    
}

+ (void)setStatisticsWithAssessmentItemRef:(AssessmentItemRef *)model andIndex:(NSString *)index
{
    BOOL b = NO ;
    if (model.correctArr && model.userResDic) {
        
        NSString    * s1 = [model.userResDic[index] stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString    * s2 = [model.correctArr[index.intValue -1] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        s2  = [s2 stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([s1 isEqualToString:s2]) {
            b = YES ;
        }
    }
    
    [self loadIsCorrect:b andRef:model];
}


+ (void)loadIsCorrect:(BOOL)b andRef:(AssessmentItemRef *)model
{
    NSString * type = nil ;
    if (model.astIndex.textPart == 1) {
        type = hearTest ;
    }else if (model.astIndex.textPart == 2)
    {
        type = readTest ;
    }else if (model.astIndex.textPart == 3)
    {
        type = whriteTest ;
    }
    
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
<<<<<<< HEAD
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"level%d",[User shareInstance].level]]; 
=======
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"level%d",[User shareInstance].level]];
    
    
    [self playWithCorOrFalse:b];
}

+ (void)playWithCorOrFalse:(BOOL)b
{
    //1.获得音效文件的全路径
    
    NSURL *url=  nil ;
    
    SystemSoundID soundID=0;
>>>>>>> c9e3ed2d6f375d16ca869ab5019aa9d98709759a

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

<<<<<<< HEAD
- (void)setSerVerConfig:(NSDictionary *)serVerConfig
{
    _serVerConfig = serVerConfig ;
    [[NSUserDefaults standardUserDefaults] setObject:serVerConfig forKey:SerVerConfig];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
=======
>>>>>>> c9e3ed2d6f375d16ca869ab5019aa9d98709759a

@end
