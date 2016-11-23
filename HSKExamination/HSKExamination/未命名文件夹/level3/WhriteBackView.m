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


- (void)AdsorptionView:(UIView *)view andRef:(AssessmentItemRef *)ref andOrder:(Order *)order
{
    BOOL b = CGRectIntersectsRect(self.frame, view.frame) ;
    
    [self reSetPointArr];

    if (b) {

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
        
        [UIView animateWithDuration:0.4 animations:^{
            view.center = minP ;
        }];

    }
    
    NSArray * arr = [self.superview subviews];
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (UIView * v in arr) {
        if ([v isKindOfClass:[WhriteItemView class]]) {
            if ( CGRectIntersectsRect(self.frame, v.frame)) {
                [array addObject:v];
            }
        }
    }
    
    
    if (array.count) {
        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            UIView * v1 = obj1 ;
            UIView * v2 = obj2 ;
            return v1.centerX > v2.centerX ;
        }];
        
        NSString * s = @"" ;
        NSString * text = @"" ;
        for (WhriteItemView * v in array) {
            NSLog(@"%@",v) ;
            s = [s stringByAppendingString:v.text.identifier];
            text = [text stringByAppendingString:v.text.textString];
        }
        
        Candidates * model =  [User shareInstance].candiateModel ;
        
        if (model) {
            ref.userChoice = [NSString stringWithFormat:@"RESPONSE=%@&RESPONSE_TEXT=%@",s,text];
        }else
        {
            ref.userChoice = s ;
            if (array.count == order.subItemArray.count) {

                ref.correctResponse = order.correctResponse ;

                if ([ref.userChoice isEqualToString:order.correctResponse]) {
                    [ShowHUD showCustomView:^UIView *{
                        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 171, 171)];
                        imageView.contentMode = UIViewContentModeScaleAspectFit ;
                        imageView.image = [UIImage imageNamed:@"对"];
                        imageView.center = CGPointMake(screenWith()/2, screenHeight()/2) ;
                        return imageView ;
                        
                    } configParameter:^(ShowHUD *config) {
                        config.backgroundColor = [UIColor clearColor];

                    } duration:1 inView:[UIApplication sharedApplication].keyWindow];
                }else
                {
                    
                    [ShowHUD showCustomView:^UIView *{
                        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 171, 171)];
                        imageView.contentMode = UIViewContentModeScaleAspectFit ;
                        imageView.image = [UIImage imageNamed:@"错"];
                        imageView.center = CGPointMake(screenWith()/2, screenHeight()/2) ;
                        return imageView ;

                    } configParameter:^(ShowHUD *config) {
                        config.backgroundColor = [UIColor clearColor];
                    } duration:1 inView:[UIApplication sharedApplication].keyWindow];

                }
                [User setStatisticsWithAssessmentItemRef:ref];
            }
            
        }
    }
    
    
  
    
}

- (void)reSetPointArr
{
    [_pointArray removeAllObjects];
    NSArray * arr = [self.superview subviews];
    
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


@end
