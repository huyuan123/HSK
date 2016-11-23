//
//  RealExerciseView.m
//  HSKExamination
//
//  Created by printer on 2016/11/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView.h"
#import "Header.h"
#import "ItemBu.h"
#import "WhriteBackView.h"
#import "WhriteItemView.h"
@implementation RealExerciseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton * lastBu = [[UIButton alloc] initWithFrame:CGRectMake(120, frame.size.height - 60, 200, 50)];
        [self addSubview:lastBu];
        UIButton * nextBu = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width -320, lastBu.y, 200, 50)];
        [self addSubview:nextBu];
        nextBu.cornerRadius = 25 ;
        lastBu.cornerRadius = 25 ;
        [lastBu setTitle:@"上一题" forState:BuNormal];
        [nextBu setTitle:@"下一题" forState:BuNormal];
        
        [lastBu setBackgroundImage:[UIImage imageNamed:@"blue"] forState:BuNormal];
        [nextBu setBackgroundImage:[UIImage imageNamed:@"blue"] forState:BuNormal];

        lastBu.tag = 100 ;
        nextBu.tag = 200 ;
        [nextBu addTarget:self action:@selector(lastOrNextEvent:) forControlEvents:BuTouchUpInside] ;
        [lastBu addTarget:self action:@selector(lastOrNextEvent:) forControlEvents:BuTouchUpInside];
        _index = (ASTIndex){1,1,0} ;
    }
    return self ;
}

- (void)lastOrNextEvent:(UIButton *)bu
{
    if(bu.tag == 100)  // 上一题
    {
        if (_block) {
            _block(NO) ;
        }
    }else if (bu.tag == 200) // 下一题
    {
        _block(YES) ;
    }
}


- (void)loadAssMent:(AssessmentItemRef *)assModel
{
    _assessection = assModel ;
    [_backView removeFromSuperview];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.height - 70)];
    _backView.clipsToBounds = YES ;
    [self addSubview:_backView];
    
    
    int        level   = [User shareInstance].candiateModel.SubjectCode.intValue ;
    NSString   *path    = [[User shareInstance].paperPath stringByAppendingPathComponent:[assModel.href lowercaseString]] ;
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
        BOOL  b1 = level == 1 &&assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 4 ;  // 等级为一的时候的条件
        BOOL  b4 = level == 2 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 4 ;
        BOOL  b7 = level == 3 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;
        BOOL  b8 = level == 4 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 3;
        BOOL  b9 = level == 4 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 3;
        BOOL  b10 = level == 6 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 4 ;
        
        BOOL b2 = level == 2 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 2 ;
        BOOL b3 = level == 2 && assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 1 ;
        BOOL b5 = level == 3 && assModel.astIndex.textPart == 1 && assModel.astIndex.assessmentSection == 1 ;
        
//        BOOL b6 = level == 3&& assModel.astIndex.textPart == 2 && assModel.astIndex.assessmentSection == 2 ;

        
        if (b1 || b4 || b7 || b8 || b9 || b10) {
            level ++ ;
        }
        
     
        
        if (b2 || b3 || b5) {
            level = 1 ;
        }
        
        
//        if (b6) {
//            level = 2 ;
//        }
        
        
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
//        if(level != 6)
//        {
            Cloze * model = [[Cloze alloc] init];
            [model parseInPath:path];
            [self loadCloze:model];
//        }else
//        {
//            Cloze6 * model = [[Cloze6 alloc] init];
//            [model ];
//        }
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
    
}

- (void)loadJudgement:(Judgement *)judgeModel
{
    if ([judgeModel isKindOfClass:[Judgement1 class]]) {
        [self loadJudgeMent1:(Judgement1 *)judgeModel];
    }else if ([judgeModel isKindOfClass:[Judgement3 class]])
    {
        [self loadJudgeMent3:(Judgement3 *)judgeModel];
    }
}



- (void)loadSingleChoice:(SingleChoice *)choice
{
    int level = [User shareInstance].candiateModel.SubjectCode.intValue ;
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

- (void)loadReadModel:(ReadingComprehensionModel *)model
{
    AssessmentItemRef * ref = _assessection ;
    if ([model isKindOfClass:[ReadingComprehensionModel1 class]]) {
        [self loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model];
    }else if ([model isMemberOfClass:[ReadingComprehensionModel2 class]])
    {
        [self loadReadingComprehensionModel2:(ReadingComprehensionModel2 *)model];
    }else if ([model isKindOfClass:[ReadingComprehensionModel3 class]])
    {
        if ([User shareInstance].candiateModel.SubjectCode.intValue == 3 && ref.astIndex.assessmentSection == 1) {
            [self loadreadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model];
        }else
        {
            [self loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model];
        }
    }else if ([model isKindOfClass:[ReadingComprehensionModel4 class]])
    {
        [self loadReadingComprehensionModel4:(ReadingComprehensionModel4 *)model];
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

- (void)loadTextEntry3:(TextEntry3 *)model
{

}

- (void)loadTextEntry:(TextEntry *)model
{

}

//- (void)loadCloze:(Cloze *)model
//{
//
//}

- (void)loadWrite:(ExtendedText *)model
{
    [self loadExtendedText:model];
}

//- (void)loadExTendedText:(ExtendedText4 *)model
//{
//
//}

- (void)loadOrder:(Order *)order
{
    
  
}



#pragma mark ----------- 用户操作事件

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
    
    [User saveUserRes:model];

}


- (void)singleChoiceEvent:(ItemBu *)bu
{
    
    NSArray * subArr = [self.backView subviews];
    for (ItemBu * view in subArr) {
        if (view == bu) {
            [view setIsSelect:YES];
        }else if([view isKindOfClass:[ItemBu class]])
        {
            [view setIsSelect:NO];
        }
    }
    
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.userChoice = bu.titleLabel.text ;
    [User saveUserRes:model];
}


- (void)itemBuEvent:(ItemBu *)bu
{
    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;

    NSArray * array = [bu.superview subviews];
    for (ItemBu * button in array) {
        if ([button isKindOfClass:[ItemBu class]]) {
            [button setIsSelect:NO];
        }
    }
    
    if (!model.userResDic) {
        model.userResDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    
    [bu setIsSelect:YES];
    
    [model.userResDic setObject:bu.titleLabel.text forKey:[NSString stringWithFormat:@"%d",(int)bu.tag -99]];
    [User saveUserRes:model];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
    model.userChoice = textField.text ;
    [User saveUserRes:model];
    return YES ;
}// return NO to not change text

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    AssessmentItemRef * model = (AssessmentItemRef *)_assessection ;
    model.userChoice = textView.text ;
    [User saveUserRes:model];
    return YES ;
}


@end
