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
- (void)playWithPath:(NSString *)path ;
@end
