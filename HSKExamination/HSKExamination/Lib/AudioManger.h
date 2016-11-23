//
//  AudioManger.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioManger : NSObject<AVAudioPlayerDelegate>

@property (nonatomic ,weak) id <AVAudioPlayerDelegate> delegate ;

@property (nonatomic ,assign) float  soundMax ;

@property (nonatomic ,assign) int  repeatCount ;

- (void)playWithPath:(NSString *)path ;

- (void)stop ;

- (void)playWithIcon:(UIView *)view AndPath:(NSString *)path ;

@end
