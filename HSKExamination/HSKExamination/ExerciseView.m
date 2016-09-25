//
//  ExerciseView.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "Judgement.h"
#import <QuartzCore/QuartzCore.h>
@implementation ExerciseView
{
    UIView          *     _backView ;
    id                    _model ;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = RGBCOLOR(133, 163, 54).CGColor ;
        self.layer.borderWidth = 2 ;
        self.cornerRadius = 20 ;

        
        CGMutablePathRef path = CGPathCreateMutable() ;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:CGRectMake(0, 0, 1, frame.size.height -40)];
        [shapeLayer setPosition:CGPointMake(frame.size.width -85, frame.size.height/2)];
        [shapeLayer setBackgroundColor:[UIColor clearColor].CGColor];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//         设置虚线颜色为blackColor
//         [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
        [shapeLayer setStrokeColor:[[UIColor grayColor] CGColor]];
//         3.0f设置虚线的宽度
        [shapeLayer setLineWidth:1.0f];
        [shapeLayer setLineJoin:kCALineJoinRound];
        // 3=线的宽度 1=每条线的间距
        [shapeLayer setLineDashPattern:
        [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
         [NSNumber numberWithInt:3],nil]];
        // Setup the path CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, 0,frame.size.height -40);
        [shapeLayer setPath:path];
        [self.layer addSublayer:shapeLayer];
        CGPathRelease(path);
    }
    
    return self ;
}

- (void)loadAssMent:(AssessmentItemRef *)assModel
{
    [_backView removeFromSuperview];
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    _backView.width -= 85 ;
    [self addSubview:_backView];
    if ([assModel.type isEqualToString:@"judgement"]) {  // 如果是判断题
        Judgement * model = [[Judgement alloc] init];
        [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
        _model = model ;
        [self loadJudgement:model];
    }
}




//  加载判断题
- (void)loadJudgement:(Judgement *)judgeModel
{

}

@end
