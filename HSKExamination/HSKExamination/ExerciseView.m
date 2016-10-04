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
#import "ExerciseView+Read.h"
#import "ReadingComprehensionModel2.h"
@implementation ExerciseView
//{
//    id                    _assessection ; //  题
//}

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
    
    [_backView addSubview:_typeImageView];
    [_backView addSubview:_countLabel];
    _countLabel.text = @"1/40" ;

    if ([assModel.type isEqualToString:@"judgement"]) {  // 如果是判断题

        Judgement * model = [[Judgement alloc] init];
        [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];

        if (assModel.astIndex.textPart == 1) {
            [self loadJudgement:model];

        }else if (assModel.astIndex.textPart == 2)
        {
            [self loadReadJudgement:model];
        }
    }else if ([assModel.type isEqualToString:@"singleChoice"])
    {
        SingleChoice * singleChoice = [[SingleChoice alloc] init];
        [singleChoice parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
        [self loadSingleChoice:singleChoice];
    }else if([assModel.type isEqualToString:@"readingComprehension"])
    {
        if (assModel.astIndex.assessmentSection == 4) {
            ReadingComprehensionModel2 * model = [[ReadingComprehensionModel2 alloc] init];
            [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
            [self loadReadModel2:model];
        }else
        {
            ReadingComprehensionModel * model = [[ReadingComprehensionModel alloc] init];
            [model parseInPath:[[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href]];
            [self loadReadModel:model];
        }
    }
}


#pragma mark------------------------------   加载判断题
//  加载判断题
- (void)loadJudgement:(Judgement *)judgeModel
{
  
    
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
    
    
    if (choice.imgArr) {
        for (int i = 0; i < choice.imgArr.count; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i*(100 + x), 200, 100, 100)];
            [_backView addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            imageView.image = [UIImage imageWithContentsOfFile:[choice.imgArr[i] src]];
            
            CGRect r = imageView.frame ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(r.origin.x , 300, 100, 100)];
            [_backView addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:[choice.simpleChoiceArray[i] identifier]  forState:BuNormal];
            bu.titleLabel.font = [UIFont boldSystemFontOfSize:24] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.tag = 1000 + i ;
            [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            if (isCanUseString(model.userChoice)) {
                if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                    [bu setIsSelect:YES];
                }
            }
        }

    }else
    {
        x = (_backView.width - 450)/4 ;
        for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + i*(150 + x), 220, 150, 100)];
            [_backView addSubview:textLabel];
//            textLabel.backgroundColor = [UIColor redColor];
            SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
            textLabel.numberOfLines = 0 ;
            textLabel.text = [choiceModel.pinYInString stringByAppendingString:@"\n"] ;
            textLabel.text = [textLabel.text stringByAppendingString:choiceModel.textString] ;
            textLabel.textAlignment = CenterText ;
            [textLabel adjustsFontSizeToFitWidth];
            
            CGRect r = textLabel.frame ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(r.origin.x , 300, 150, 100)];
            [_backView addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:[choice.simpleChoiceArray[i] identifier]  forState:BuNormal];
            bu.titleLabel.font = [UIFont boldSystemFontOfSize:24] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.tag = 1000 + i ;
            [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            if (isCanUseString(model.userChoice)) {
                if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                    [bu setIsSelect:YES];
                }
            }
        }

    }
    
    
    
    
    [_manger playWithPath:choice.media.src];
}

- (void)singleChoiceEvent:(ItemBu *)bu
{

    NSArray * subArr = [_backView subviews];
    for (ItemBu * view in subArr) {
        if (view == bu) {
            [view setIsSelect:YES];
        }else if([view isKindOfClass:[ItemBu class]])
        {
            [view setIsSelect:NO];
        }
    }
     AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
     model.userChoice = bu.titleLabel.text ;
    
}


#pragma mark------------------------------   加载阅读理解
- (void)loadReadModel:(ReadingComprehensionModel *)model
{

    if (model.imgArray.count) {
        
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

    }else if (model.topicArray.count)  // 阅读理解力没有图片的那种
    {
        for (int i = 0; i < model.topicArray.count  ; i++) {
            SimpleChoice * choice = model.topicArray[i] ;
            UILabel *  label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 170 + 60*i, 30, 30)];
            [_backView addSubview:label1];
            label1.text = [model.topicArray[i] identifier] ;

            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 170 + 60*i, 220, 40)];
            label.numberOfLines = 0 ;
            [_backView addSubview:label];
            label.text = [choice.pinYInString stringByAppendingString:@"\n"] ;
            label.text = [label.text stringByAppendingString:choice.textString];
            [label adjustsFontSizeToFitWidth];
            label1.font = label.font = Font14 ;
        }
    }
    
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)_assessection ;

    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(300, 170 + 80*i, 320, 50)];
        if (modelref.userResDic && modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]]) {
            view.userRes =  modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]] ;
        }
        [_backView addSubview:view];
        
        [view loadData:[model.subItemArr[i] array] andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
        [view setClickBlock:^(NSString * num, NSString * userRes) {
            if (modelref.userResDic == nil) {
                modelref.userResDic = [NSMutableDictionary dictionaryWithCapacity:5];
            }
            
            [modelref.userResDic setObject:userRes forKey:num];
        }];
        
        if (modelref.astIndex.textPart == 2) {
            [view loadsimpleChoice:model.subItemArr[i]];
        }
    }

    if (modelref.astIndex.textPart == 1) {
        [_manger playWithPath:model.media.src] ;
    }else
    {
        [_manger stop];
    }
}


#pragma mark------------------------------   加载第二种阅读理解
- (void)loadReadModel2:(ReadingComprehensionModel2 *)model
{
    NSString * string = @"" ;
    for (int i = 0; i < model.topicArray.count; i++) {
        string = [string stringByAppendingFormat:@"       %@",[model.topicArray[i] identifier]];
        string = [string stringByAppendingFormat:@" %@",[model.topicArray[i] textString]];
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, _backView.width, 30)];
    [_backView addSubview:label];
    label.text = string ;
    label.textAlignment = CenterText ;
    
    
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, _backView.width, _backView.height - 200)];
    [_backView addSubview:scro];
    
    NSArray * titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F"] ;
    for (int i = 0; i < model.subItemArr.count; i++) {
        UILabel * topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, i*80, _backView.width -80, 30)];
        topicLabel.text = [model.subItemArr[i] textString] ;
        topicLabel.text = [[NSString stringWithFormat:@"%d. ",i +1] stringByAppendingString:topicLabel.text];
        [scro addSubview:topicLabel];
        
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(40, topicLabel.bottom -20, topicLabel.width, 60)];
        [scro addSubview:view];
        [view loadData:titleArray andTitle:@""];
        [view setClickBlock:^(NSString * num, NSString * select) {
            
        }];
    }
}

@end
