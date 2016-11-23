//
//  SoundDebugTestBackView.m
//  HSKExamination
//
//  Created by printer on 2016/10/27.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SoundDebugTestBackView.h"

@implementation SoundDebugTestBackView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int count = frame.size.width / 12 ;
        for (int i = 0; i < count; i++) {
            UIView * Item = [[UIView alloc] initWithFrame:CGRectMake(i*12, 0, 6, frame.size.height)];
            [self addSubview:Item];
            Item.backgroundColor = RGBCOLOR(190, 226, 47) ;
        }
    }
    
    return self ;
}

- (void)setVoluem:(float)voluem
{
    _voluem = voluem ;
    float width = self.width*voluem ;
    NSArray * array = [self subviews];
    for (UIView * view in array) {
        if (view.right < width) {
            view.backgroundColor = RGBCOLOR(190, 226, 47) ;
        }else
        {
            view.backgroundColor = RGBCOLOR(218, 218, 218) ;

        }
    }
}
@end
