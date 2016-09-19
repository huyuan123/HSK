//
//  ChooseOneButton.m
//  USA
//
//  Created by YouXianMing on 14/12/9.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import "ChooseOneButton.h"

typedef enum : NSUInteger {
    UIButton_one = 0x11,
    UIButton_two,
    UIButton_three,
} EnumChooseOneButton;

@interface ChooseOneButton ()

@property (nonatomic, strong) LabelRotateView  *labelView1;
@property (nonatomic, strong) LabelRotateView  *labelView2;
@property (nonatomic, strong) LabelRotateView  *labelView3;

@property (nonatomic, assign) CGFloat  labelWidth;
@property (nonatomic, assign) CGFloat  labelHeight;

@end

@implementation ChooseOneButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _labelWidth  = frame.size.width / 3.f;
        _labelHeight = frame.size.height;
        
        // 按钮1
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(_labelWidth*0, 0,
                                                                       _labelWidth,
                                                                       _labelHeight)];
        button1.tag = UIButton_one;
        [button1 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        
        // 按钮2
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(_labelWidth*1, 0,
                                                                       _labelWidth,
                                                                       _labelHeight)];
        button2.tag = UIButton_two;
        [button2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        // 按钮3
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(_labelWidth*2, 0,
                                                                       _labelWidth,
                                                                       _labelHeight)];
        button3.tag = UIButton_three;
        [button3 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];

        // 标签1
        _labelView1 = [[LabelRotateView alloc] initWithFrame:CGRectMake(0, 0,
                                                                        _labelWidth,
                                                                        _labelHeight)];
        _labelView1.title = @"Top Rated";
        _labelView1.rotateViewOffsetX = 35;
        _labelView1.userInteractionEnabled = NO;
        [button1 addSubview:_labelView1];
        
        // 标签2
        _labelView2 = [[LabelRotateView alloc] initWithFrame:CGRectMake(0, 0,
                                                                        _labelWidth,
                                                                        _labelHeight)];
        _labelView2.title = @"Distance";
        _labelView2.rotateViewOffsetX = 35;
        [button2 addSubview:_labelView2];
        _labelView2.userInteractionEnabled = NO;
        [_labelView2 changeToDisableStateAnimated:NO];
        
        // 标签3
        _labelView3 = [[LabelRotateView alloc] initWithFrame:CGRectMake(0, 0,
                                                                        _labelWidth,
                                                                        _labelHeight)];
        _labelView3.title = @"Minimum";
        _labelView3.rotateViewOffsetX = 35;
        [button3 addSubview:_labelView3];
        _labelView3.userInteractionEnabled = NO;
        [_labelView3 changeToDisableStateAnimated:YES];
    }
    return self;
}

- (void)buttonEvents:(UIButton *)button {
    
    if (button.tag == UIButton_one) {
        [_labelView1 changeToNormalStateAnimated:YES];
        [_labelView2 changeToDisableStateAnimated:YES];
        [_labelView3 changeToDisableStateAnimated:YES];
        
        if (_delegate && [_delegate respondsToSelector:@selector(chooseOneButton:)]) {
            [_delegate chooseOneButton:0];
        }
        
    } else if (button.tag == UIButton_two) {
        [_labelView1 changeToDisableStateAnimated:YES];
        [_labelView2 changeToNormalStateAnimated:YES];
        [_labelView3 changeToDisableStateAnimated:YES];
        
        if (_delegate && [_delegate respondsToSelector:@selector(chooseOneButton:)]) {
            [_delegate chooseOneButton:1];
        }
    } else {
        [_labelView1 changeToDisableStateAnimated:YES];
        [_labelView2 changeToDisableStateAnimated:YES];
        [_labelView3 changeToNormalStateAnimated:YES];
        
        if (_delegate && [_delegate respondsToSelector:@selector(chooseOneButton:)]) {
            [_delegate chooseOneButton:2];
        }
    }
}

@end
