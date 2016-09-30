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
#import "SingleChoice.h"
#import "ReadingComprehensionModel.h"
#import "SelectView.h"
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
    _backView.clipsToBounds = YES ;
    _backView.width -= 85 ;
    [self addSubview:_backView];
    if ([assModel.type isEqualToString:@"judgement"]) {  // 如果是判断题
        Judgement * model = [[Judgement alloc] init];
        [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
        _model = model ;
        [self loadJudgement:model];
    }else if ([assModel.type isEqualToString:@"singleChoice"])
    {
        SingleChoice * singleChoice = [[SingleChoice alloc] init];
        [singleChoice parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
        _model = singleChoice ;
        [self loadSingleChoice:singleChoice];
    }else if([assModel.type isEqualToString:@"readingComprehension"])
    {
        ReadingComprehensionModel * model = [[ReadingComprehensionModel alloc] init];
        [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
        _model = model ;
        [self loadReadModel:model];
    }
}





#pragma mark------------------------------   加载判断题
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


#pragma mark------------------------------   加载单选题

- (void)loadSingleChoice:(SingleChoice *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
    [_backView addSubview:_typeImageView];
    [_backView addSubview:_countLabel];
    _countLabel.text = @"1/40" ;
    
    
    float x = (_backView.width - 300)/4 ;
    for (int i = 0; i < choice.imgArr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i*(100 + x), 200, 100, 100)];
        [_backView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        imageView.image = [UIImage imageWithContentsOfFile:[choice.imgArr[i] src]];
        
        CGRect r = imageView.frame ;
        UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(r.origin.x, 300, 100, 100)];
        [_backView addSubview:bu];
        [bu setTitle:choice.simpleChoiceArray[i]  forState:BuNormal];
        bu.titleLabel.font = [UIFont boldSystemFontOfSize:30] ;
        [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
        bu.tag = 1000 + i ;
        [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
        if (isCanUseString(model.userChoice)) {
            if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                [bu setTitleColor:[UIColor redColor] forState:BuNormal];
            }
        }
    }
    [_manger playWithPath:choice.media.src];
}

- (void)singleChoiceEvent:(UIButton *)bu
{
    for (int i = 0; i < 3; i++) {
        UIButton * button = [_backView viewWithTag:1000 +i];
        if (button == bu) {
            [button setTitleColor:[UIColor redColor] forState:BuNormal];
        }else
        {
            [button setTitleColor:[UIColor blackColor] forState:BuNormal];
        }
    
    }
    
     AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
    model.userChoice = bu.titleLabel.text ;
    
}


#pragma mark------------------------------   加载阅读理解
- (void)loadReadModel:(ReadingComprehensionModel *)model
{
    float y = 170 ;

    for(int i = 0; i < model.imgArray.count ; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + i%2*120, y+i/2*135, 100, 115)];
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        imageView.image = [UIImage imageWithContentsOfFile:[model.imgArray[i] src]];
        [_backView addSubview:imageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, 30, 30)];
        const char cha = i + 65 ;
        label.text = [NSString stringWithUTF8String:&cha] ;
        label.cornerRadius = 15 ;
        label.backgroundColor = RGBCOLOR(190, 226, 47) ;
        label.textColor = [UIColor whiteColor] ;
        [imageView addSubview:label];
        label.textAlignment = CenterText ;
        label.font = Font24 ;
    }
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(300, 170 + 80*i, 320, 50)];
        [_backView addSubview:view];
        [view loadData:model.subItemArr[i] andTitle:[NSString stringWithFormat:@"%d",i]];
    }

//    view.backgroundColor = [UIColor redColor];
//    [_manger playWithPath:model.media.src];
}

@end
