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
#import "Header.h"
#import "Order.h"
#import "TextEntry3.h"
@implementation ExerciseView

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
//    _countLabel.text = @"1/40" ;
    
    if(assModel.astIndex.textPart == 1)
    {
        _typeImageView.image = [UIImage imageNamed:@"听力图标"];

    }else if (assModel.astIndex.textPart == 2)
    {
        _typeImageView.image = [UIImage imageNamed:@"阅读图标-pre"];

    }else if (assModel.astIndex.textPart == 3)
    {
        _typeImageView.image = [UIImage imageNamed:@"写作图标-pre"];
    }
    
    if (self.manger) {
        [self.manger stop];
    }
    
    int        level   = [User shareInstance].level ;
    NSString   *path    = [[User shareInstance].paperPath stringByAppendingPathComponent:assModel.href] ;
    if ([assModel.type isEqualToString:@"judgement"]) {  // 如果是判断题

        BOOL b = level == 2 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 3 ;
        if (b) {
            level ++ ;
        }
        
        BOOL b1 = level == 4 && assModel.astIndex.textPart == 1 ;
        
        if (b1) {
            level -- ;
        }
        
        Judgement * model = [Judgement createChildWithLevel:level];
        [model parseInPath:path];
        [self loadJudgement:model];

    }else if ([assModel.type isEqualToString:@"singleChoice"])
    {
        BOOL b = level == 3 && assModel.astIndex.textPart == 1 ;
        BOOL b1 = level == 4 && assModel.astIndex.textPart == 1 ;
        BOOL b2 = level == 4 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 3 ;
        BOOL b3 = level == 5 && assModel.astIndex.textPart == 1 ;
        BOOL b4 = level == 6 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 1 ;
        BOOL b5 = level == 5 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;

        
        if (b || b1 || b4 ) {
            level = 1 ;
        }
        
        if (b2 || b3 || b5) {
            level = 3 ;
        }
        
        SingleChoice * singleChoice = [SingleChoice createChildWithLevel:level];
        [singleChoice parseInPath:path];
        [self loadSingleChoice:singleChoice];
        
    }else if([assModel.type isEqualToString:@"readingComprehension"])
    {
        BOOL  b1 = level == 1 && assModel.astIndex.assessmentSection == 4 ;  // 等级为一的时候的条件
        BOOL  b4 = level == 2 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 4 ;
        BOOL  b7 = level == 3 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;
        BOOL  b8 = level == 4 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 3;
        BOOL  b9 = level == 4 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 3;
        BOOL  b10 = level == 6 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 4 ;

        if (b1 || b4 || b7 || b8 || b9 || b10) {
            level ++ ;
        }
        
        BOOL b2 = level == 2 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 2 ;
        BOOL b3 = level == 2 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 1 ;
        BOOL b5 = level == 3 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 1 ;
        
        if (b2 || b3 || b5) {
            level = 1 ;
        }
        
        BOOL b6 = level == 3&& assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;
        
        if (b6) {
            level = 2 ;
        }
        
        
        ReadingComprehensionModel * readModel = [ReadingComprehensionModel createChildWithLevel:level] ;
        [readModel parseInPath:path];
        [self loadReadModel:readModel];

    }else if ([assModel.type isEqualToString:@"textEntry"])
    {
        ProblemModel * model = nil ;
        if (level == 3) {
            model = [[TextEntry3 alloc] init];
        }else
        {
            model =    [[TextEntry alloc] init];
        }
        
        [model parseInPath:path];
        
        if (level == 3) {
            [self loadTextEntry3:model];
        }else
        {
        [self loadTextEntry:model];
        }
    }else if ([assModel.type isEqualToString:@"cloze"])
    {
        Cloze * model = [[Cloze alloc] init];
        [model parseInPath:path];
        [self loadCloze:model];
    }else if ([assModel.type isEqualToString:@"extendedText"])
    {
        if (level == 6) {
            ExtendedText * extendModel = [[ExtendedText alloc] init] ;
            [extendModel parseInPath:path];
            [self loadWrite:extendModel];

        }else if (level == 4 || level == 5)
        {
            ExtendedText4 * extendModel = [[ExtendedText4 alloc] init] ;
            [extendModel parseInPath:path];
            [self loadExTendedText:extendModel];

        }
        
    }else if ([assModel.type isEqualToString:@"order"])
    {
        Order * order = [[Order alloc] init];
        [order parseInPath:path];
        [self loadOrder:order];
    }
    
    
    NSArray * arr = [_backView subviews];
    for (UIView * v in arr) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            [v addSubview:_countLabel];
            [v addSubview:_typeImageView];
        }
    }
    
}

#pragma mark------------------------------   加载写作
- (void)loadWrite:(ExtendedText *)model
{
    [self loadExtendedText:model];
}

#pragma mark------------------------------   加载排序

//- (void)loadTextEntry:(TextEntry *)entry
//{
//
//}

#pragma mark------------------------------   加载判断题
//  加载判断题
- (void)loadJudgement:(Judgement *)judgeModel
{
  
    if ([judgeModel isKindOfClass:[Judgement1 class]]) {
        [self loadJudgeMent1:(Judgement1 *)judgeModel];
    }else if ([judgeModel isKindOfClass:[Judgement3 class]])
    {
        [self loadJudgeMent3:(Judgement3 *)judgeModel];
    }
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
    [User setStatisticsWithAssessmentItemRef:model];

}


#pragma mark------------------------------   加载单选题

- (void)loadSingleChoice:(SingleChoice *)choice
{
    int level = [User shareInstance].level ;
    AssessmentItemRef * assModel = (AssessmentItemRef *)_assessection ;
    
    if ([choice isKindOfClass:[SingleChoice1 class]]) {
        if (level == 4 || level == 5) {
            [self loadSingleChoice4:(SingleChoice1 *)choice];
        }else if (level == 6)
        {
            [self loadSingleChoice6:(SingleChoice1 *)choice];
        }
        else
        {
            [self loadSingleChoice1:(SingleChoice1 *)choice];
        }
    }else if ([choice isKindOfClass:[SingleChoice3 class]])
    {
        BOOL b5 = level == 5 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;

        if (b5) {
            [self loadSingleChoice5:choice];
        }else
        {
            [self loadSingleChoice3:(SingleChoice3 *)choice];
        }
    }else if ([choice isKindOfClass:[SingleChoice6 class]])
    {
        [self loadSingle6:(SingleChoice6 *)choice];
    }
    

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
    [User setStatisticsWithAssessmentItemRef:model];
}


#pragma mark------------------------------   加载阅读理解
- (void)loadReadModel:(ReadingComprehensionModel *)model
{
    if ([model isKindOfClass:[ReadingComprehensionModel1 class]]) {
        [self loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model];
    }else if ([model isMemberOfClass:[ReadingComprehensionModel2 class]])
    {
        [self loadReadingComprehensionModel2:(ReadingComprehensionModel2 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel3 class]])
    {
        [self loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel4 class]])
    {
        [self loadReadingComprehensionModel2:(ReadingComprehensionModel2 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel5 class]])
    {
        [self loadReadingComprehensionModel5:(ReadingComprehensionModel5 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel6 class]])
    {
        [self loadReadingComprehensionModel6:(ReadingComprehensionModel6 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel7 class]])
    {
        [self loadReadingComprehensionModel7:(ReadingComprehensionModel7 *)model];
    }
}


#pragma mark 加载写作题

- (void)setManger:(AudioManger *)manger
{
    _manger = manger ;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(buttonIndex == 1)
    {
        [_delegate next];
    }
}



@end
