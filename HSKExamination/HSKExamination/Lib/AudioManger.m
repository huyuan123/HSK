//
//  AudioManger.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "AudioManger.h"

@implementation AudioManger
{
    AVAudioPlayer * _play ;
}

- (id)init
{
    self  = [super init] ;
    if (self) {
    }
    
    return self ;
}

- (void)playWithPath:(NSString *)path
{
    if (_play) {
        [_play stop];
        _play = nil ;
    }
    
    _play = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    _play.delegate = self.delegate ;
    [_play prepareToPlay];
    [_play play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

}


@end
