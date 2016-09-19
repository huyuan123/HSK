//
//  LoadingRotateView.m
//  USA
//
//  Created by XianMingYou on 15/2/3.
//  Copyright (c) 2015年 fuhuaqi. All rights reserved.
//

#import "LoadingRotateView.h"

@implementation LoadingRotateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image        = [UIImage imageNamed:@"L_loadding"];
        [self addSubview:imageView];
        
        NSInteger countAndDuration = 6000;
        NSInteger speed            = 3;
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue           = [NSNumber numberWithFloat:(speed * M_PI_4) * countAndDuration];
        rotationAnimation.duration          = countAndDuration;
        rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [imageView.layer addAnimation:rotationAnimation forKey:nil];
    }
    return self;
}

@end
