//
//  LemonRotateView.m
//  USA
//
//  Created by XianMingYou on 15/3/18.
//  Copyright (c) 2015年 fuhuaqi. All rights reserved.
//

#import "LemonRotateView.h"

@interface LemonRotateViewStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation LemonRotateViewStoreValue
@end

@interface LemonRotateView ()
@property (nonatomic, strong) UIImageView                *imageView;
@property (nonatomic, strong) LemonRotateViewStoreValue  *storeValue;
@end


@implementation LemonRotateView


- (void)buildView {
    
    
    // 初始化view
    CGFloat width    = self.frame.size.width;
    CGFloat height   = self.frame.size.height;
    _imageView       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _imageView.image = [UIImage imageNamed:@"L_loadding"];
    [self addSubview:_imageView];
    
    // 存储基本值
    self.storeValue           = [LemonRotateViewStoreValue new];
    self.storeValue.midRect   = _imageView.frame;
    _imageView.y             -= 10;
    self.storeValue.startRect = _imageView.frame;
    _imageView.y             += 20;
    self.storeValue.endRect   = _imageView.frame;
    _imageView.frame          = self.storeValue.startRect;
    
    
    
    _imageView.alpha = 0.f;
}

- (void)show {
    NSInteger countAndDuration = 6000;
    NSInteger speed            = 3;
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue           = [NSNumber numberWithFloat:(speed * M_PI_4) * countAndDuration];
    rotationAnimation.duration          = countAndDuration;
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.imageView.layer addAnimation:rotationAnimation forKey:nil];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.storeValue.midRect;
        self.imageView.alpha = 1.f;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.storeValue.endRect;
        self.imageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.imageView.frame = self.storeValue.startRect;
    }];
}

@end
