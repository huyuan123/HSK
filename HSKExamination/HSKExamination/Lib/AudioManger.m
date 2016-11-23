//
//  AudioManger.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "AudioManger.h"

@interface AudioManger  ()

@property (nonatomic ,weak) UIView  *   proGressView ;
@property (nonatomic ,weak) UIView  *   kuangView ;
@property (nonatomic ,strong) NSString  *   src ;

@end

@implementation AudioManger
{
    AVAudioPlayer       *       _play ;
    NSTimer             *       _timer ;
}

- (id)init
{
    self  = [super init] ;
    if (self) {
        _soundMax = 1 ;
        _repeatCount = 1 ;
    }
    
    return self ;
}

- (void)playWithPath:(NSString *)path
{
    if (_play) {
        [_play stop];
        _play = nil ;
    }
    
    
    if ([path rangeOfString:@"\\"].length) {
        path = [path stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }
    
    NSFileManager * manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:path]) {
        if ([path rangeOfString:@"AssessmentItems"].length > 0) {
            path = [path stringByReplacingOccurrencesOfString:@"AssessmentItems" withString:@"assessmentitems"];
        }
    }

    _src = path ;

    NSLog(@"%@",path) ;
    _play = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    _play.volume = _soundMax ; ;
//    _play.numberOfLoops = _repeatCount ;
    _play.delegate = self.delegate ;
    [_play prepareToPlay];
    [_play play];

}


- (void)setSoundMax:(float)soundMax
{
    NSLog(@"%f",soundMax) ;
    _soundMax      = soundMax ;
    _play.volume   = soundMax ;
    [_play updateMeters];
}

- (void)stop
{
    [_play stop] ;
    _play = nil ;
    [_timer invalidate] ;
    _timer = nil ;
    [[_kuangView viewWithTag:8899] removeFromSuperview];
    [[_kuangView viewWithTag:9988] removeFromSuperview];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_play stop];
}

- (void)playWithIcon:(UIView *)view AndPath:(NSString *)path
{
    if (_play) {
        [_play stop];
        _play = nil ;
    }
    
    if ([path rangeOfString:@"\\"].length) {
       path = [path stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }
    
    
    NSFileManager * manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:path]) {
        if ([path rangeOfString:@"AssessmentItems"].length > 0) {
            path = [path stringByReplacingOccurrencesOfString:@"AssessmentItems" withString:@"assessmentitems"];
        }
    }

    _src = path ;
    
    
    NSLog(@"===================%@",path) ;
    _play = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    _play.volume = _soundMax ; ;
    _play.delegate = self.delegate ;
    [_play prepareToPlay];
    [_play play];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeEvent:) userInfo:nil repeats:YES];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(250, 50, 375, 15)];
    [backView setBackgroundColor:RGBCOLOR(218, 218, 218)];
    [view addSubview:backView];
    backView.tag = 9988 ;
    
    UIView * progressView = [[UIView alloc] initWithFrame:backView.bounds];
    [backView addSubview:progressView];
    progressView.backgroundColor = RGBCOLOR(190, 226, 47) ;
    progressView.width = 1 ;
    backView.cornerRadius = 7.5 ;
    progressView.cornerRadius = 7.5 ;
    _proGressView = progressView ;
    _kuangView = view ;
    
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(200, 40, 60, 40)];
    [bu setImage:[UIImage imageNamed:@"喇叭图标"] forState:BuNormal];
    [view addSubview:bu];
    bu.tag = 8899 ;
    [bu addTarget:self action:@selector(playAgain) forControlEvents:BuTouchUpInside];
}

- (void)playAgain
{
    [self playWithIcon:_kuangView AndPath:_src] ;
}

- (void)timeEvent:(NSTimer *)timer
{
    NSLog(@"%f",_play.currentTime) ;
    if (_play.currentTime == 0) {
        [timer invalidate];
        _timer = nil ;
        _proGressView.width = _proGressView.superview.width ;
    }else
    {
        _proGressView.width = _play.currentTime/_play.duration*_proGressView.superview.width ;
    }
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil ;
    [_play stop];
}

@end
