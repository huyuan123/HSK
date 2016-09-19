//
//  LabelRotateView.m
//  USA
//
//  Created by YouXianMing on 14/12/9.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import "LabelRotateView.h"

@interface LabelRotateView ()

@property (nonatomic, strong) UILabel *normalLabel;
@property (nonatomic, strong) UILabel *disableLabel;

@end

@implementation LabelRotateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {        
        _normalLabel            = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _disableLabel           = [[UILabel alloc] initWithFrame:_normalLabel.bounds];
        _normalLabel.textColor  = [UIColor colorWithRed:1.000 green:0.761 blue:0.000 alpha:1];
//        _disableLabel.textColor = COLOR_SML_TITLE;
        _normalLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _disableLabel.font = [UIFont systemFontOfSize:14.f];
        
        _normalLabel.textAlignment = NSTextAlignmentCenter;
        _disableLabel.textAlignment = NSTextAlignmentCenter;
        
        _disableLabel.alpha = 0;
        _normalLabel.alpha  = 1;
        
        [self addSubview:_disableLabel];
        [self addSubview:_normalLabel];
        
        _rotateView                  = [[RotateView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
//        UIImageView *arrow           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头－小"]];
//        UIImageView *arrowDis        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头－小灰"]];
        UIImageView *arrow           = [[UIImageView alloc] initWithFrame:CGRectZero];
        UIImageView *arrowDis        = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rotateView.normalInputView  = arrow;
        _rotateView.disableInputView = arrowDis;
        _rotateView.center           = self.center;
        
        
        [self addSubview:_rotateView];
    }
    return self;
}

- (void)changeToNormalStateAnimated:(BOOL)animated {
    [_rotateView changeToUpAnimated:animated];
    [_rotateView fadeToNormalInputViewAnimated:animated];
    
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            _normalLabel.alpha = 1.f;
            _disableLabel.alpha = 0.f;
        }];
    } else {
        _normalLabel.alpha = 1.f;
        _disableLabel.alpha = 0.1f;
    }
}
- (void)changeToDisableStateAnimated:(BOOL)animated {
    [_rotateView changeTodownAnimated:animated];
    [_rotateView fadeToDisableInputViewAnimated:animated];
    
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            _normalLabel.alpha = 0.f;
            _disableLabel.alpha = 1.f;
        }];
    } else {
        _normalLabel.alpha = 0.f;
        _disableLabel.alpha = 1.f;
    }
}

@synthesize title = _title;
- (void)setTitle:(NSString *)title {
    _title = title;
    _normalLabel.text = title;
    _disableLabel.text = title;
}
- (NSString *)title {
    return _title;
}

@synthesize rotateViewOffsetX = _rotateViewOffsetX;
- (void)setRotateViewOffsetX:(CGFloat)rotateViewOffsetX {
    _rotateViewOffsetX = rotateViewOffsetX;
    _rotateView.x     += rotateViewOffsetX;
}
- (CGFloat)rotateViewOffsetX {
    return _rotateViewOffsetX;
}

@end
