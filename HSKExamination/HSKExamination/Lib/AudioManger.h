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

- (void)playWithPath:(NSString *)path ;

- (void)stop ;
@end
