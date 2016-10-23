//
//  WhriteBackView.m
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "WhriteBackView.h"
#import "WhriteItemView.h"
@implementation WhriteBackView
{
    NSMutableArray  * _pointArray ;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(178, 164, 158) ;
        _pointArray = [NSMutableArray array];

    }
    
    return self ;
}


- (void)AdsorptionView:(UIView *)view
{
    BOOL b = CGRectIntersectsRect(self.frame, view.frame) ;
    
    [self reSetPointArr];

    if (b) {
//        NSLog(@"有重叠") ;

        CGPoint  minP = CGPointMake(10000, 10000) ; // 距离最近的点
        for (int i = 0; i < _count; i++) {
            CGPoint  p =  [self.superview convertPoint:CGPointMake(65 + 110 * i, 55/2) fromView:self]  ;
            CGFloat distance1 = [Tools distanceWithPoint1:p andPoint2:view.center] ;
            CGFloat distance2 = [Tools distanceWithPoint1:minP andPoint2:view.center];
            if (distance1 < distance2 && ![_pointArray containsObject:NSStringFromCGPoint(p)]) {
                minP = p ;
            }
        }
        
        
        
        [_pointArray addObject:NSStringFromCGPoint(minP)];
        
//        NSLog(@"%@",_pointArray) ;
        [UIView animateWithDuration:0.4 animations:^{
            view.center = minP ;
        }];

    }else
    {
    }
}

- (void)reSetPointArr
{
    [_pointArray removeAllObjects];
    NSArray * arr = [self.superview subviews];
    
    NSLog(@"%@",arr) ;
    for (WhriteItemView * itemView in arr) {
        if ([itemView isKindOfClass:[WhriteItemView class]]) {
            for (int i = 0; i < _count; i++) {
                CGPoint  p =  [self.superview convertPoint:CGPointMake(65 + 110 * i, 55/2) fromView:self]  ;
                if (p.x == itemView.centerX && p.y == itemView.centerY) {
                    [_pointArray addObject:NSStringFromCGPoint(p)];
                }
            }
        }
    }
}

//- (void)setCount:(int)count
//{
//    self.contentSize = CGSizeMake(40 + count * 110, 1) ;
//}

@end
