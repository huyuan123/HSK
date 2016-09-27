//
//  ExerciseView.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView.h"
#import "Judgement.h"
#import "ItemBu.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioManger.h"
@implementation ExerciseView
{
    UIView          *     _backView ;
    id                    _model ;
    UILabel         *     _countLabel ;
    UIImageView     *     _typeImageView ;
    
    id                    _assessection ; //  题
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
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 100, 40)];
        _countLabel.font = [UIFont boldSystemFontOfSize:30] ;
        _countLabel.textColor = RGBCOLOR(133, 163, 54) ;
        
        _typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 40, 35)];
        _typeImageView.contentMode = UIViewContentModeScaleAspectFit ;
        _typeImageView.image = [UIImage imageNamed:@"听力图标"];
        
    }
    
    return self ;
}

- (void)loadAssMent:(AssessmentItemRef *)assModel
{
    _assessection = assModel ;
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
  
    [_backView addSubview:_typeImageView];
    [_backView addSubview:_countLabel];
    _countLabel.text = @"1/40" ;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, judgeModel.img.width.floatValue, judgeModel.img.height.floatValue)];
    [_backView addSubview:imageView];
    
    
    imageView.image = [UIImage imageWithContentsOfFile:judgeModel.img.src];
    CGPoint p = _backView.middlePoint ;
    imageView.center = CGPointMake(p.x, p.y - 100) ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake((_backView.width -340)/2, imageView.bottom + 10, 340, 75)];
    [_backView addSubview:view];
    view.cornerRadius = 37.5 ;
    view.backgroundColor = RGBCOLOR(229, 229, 229) ;
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 10, 75)];
    [view addSubview:line];
    line.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 2; i++) {
        ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(0 + i*175, 0, 165, 75)];
        [view addSubview:bu];
        bu.tag = 1000 + i ;
        bu.imageName = judgeModel.simpleChoiceArray[i] ;
        [bu addTarget:self action:@selector(JudgementEvent:) forControlEvents:BuTouchUpInside];
    }
    
    
    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;

    if (isCanUseString(model.userChoice)) {
        if ([model.userChoice isEqualToString:@"T"]) {
            ItemBu * bu = [_backView viewWithTag:1000];
            [bu setIsSelect:YES];
        }else
        {
            ItemBu * bu = [_backView viewWithTag:1001];
            [bu setIsSelect:YES];
        }
    }
    
    [_manger playWithPath:judgeModel.media.src];
}

- (void)JudgementEvent:(UIButton *)bu
{
    for(int i = 0 ; i < 2 ; i++)
    {
       ItemBu * button = [_backView viewWithTag:1000 +i];
        if (button == bu) {
            [button setIsSelect:YES];
        }else
        {
            [button setIsSelect:NO];
        }
    }
    
    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
    if (bu.tag == 1000) {
        model.userChoice = @"T" ;
    }else
    {
        model.userChoice = @"F" ;
    }
}

@end
