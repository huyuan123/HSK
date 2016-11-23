//
//  WhriteItemView.m
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "WhriteItemView.h"

@implementation WhriteItemView
{
    UILabel     *       textLabel ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 90, 40)];
    if (self) {
        self.cornerRadius = 10 ;
        self.backgroundColor = RGBCOLOR(188, 225, 83);
        self.clipsToBounds = YES ;
        textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:textLabel];
        textLabel.textAlignment = CenterText ;
        textLabel.textColor = [UIColor whiteColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
        [self addGestureRecognizer:pan];
    }
    
    return self ;
}

- (void)panEvent:(UIPanGestureRecognizer *)pan
{

    CGPoint  pt = self.frame.origin ;
    
    CGPoint  p = [pan translationInView:[self superview]];
    
    if (p.x + pt.x < 0 || p.y + pt.y < 0 || pt.x + p.x > self.superview.width - 90 || p.y + pt.y > self.superview.height - 40) {
        return ;
    }
    
   CGPoint  pCenter = self.center ;
    self.center = CGPointMake(pCenter.x + p.x, pCenter.y + p.y) ;
    [pan setTranslation:CGPointZero inView:[self superview]];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (_block) {
            _block() ;
        }
    }
}

- (void)setText:(SimpleChoice *)text
{
    _text = text ;
    textLabel.text = text.textString ;
}

@end
