//
//  NumberView.m
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "NumberView.h"
#import "assessmentItemRef.h"
#import "AssessmentSection.h"
#import "NumberButton.h"
#import "Header.h"
@implementation NumberView
{
    UIView          * _backView ;
    NSArray         * _titleArray ; // 题目序号集合
    UIScrollView    * _scorView ;
    int               _buttonIndex ;
}



- (id)initWithFrame:(CGRect)frame andBlock:(void(^)(AssessmentItemRef * itemRef))ClickBlock 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = RGBCOLOR(133, 163, 54).CGColor ;
        self.layer.borderWidth = 2 ;
        self.cornerRadius = 20 ;
        _ClickBlock = ClickBlock ;
    }
    
    return self ;
}

- (void)loadTestPart:(TestPart *)part
{
    
    _buttonIndex = -1 ;

    [_backView removeFromSuperview];
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_backView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 85)];
    titleLabel.font = Font20 ;
    titleLabel.textAlignment = CenterText ;
    titleLabel.textColor = RGBCOLOR(133, 163, 54) ;
    [_backView addSubview:titleLabel];
    
    
    int partType = -1 ;
    if ([part.identifier isEqualToString:@"P01"]) {
        titleLabel.text = @"听力练习" ;
        partType = 0 ;
    }else
    if ([part.identifier isEqualToString:@"P02"]) {
        partType = 1 ;
        titleLabel.text  = @"阅读练习" ;
    }else
    if ([part.identifier isEqualToString:@"P03"]) {
        partType = 2 ;
        titleLabel.text = @"书写练习" ;
    }else
        if ([part.identifier isEqualToString:@"P04"]) {
            partType = 2 ;
            titleLabel.text = @"随机练习" ;
        }
    _scorView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, self.width, self.height - 95)];
    [_backView addSubview:_scorView];
    
    int i = 0 ;
    int section = -1 ;
    int assrssref = -1 ;

    NSMutableArray * muArray = [NSMutableArray arrayWithCapacity:10];
    for (AssessmentSection * sec in part.assessmentSectionArray) {
        section++ ;
        assrssref = 0 ;
        for (AssessmentItemRef * model in sec.assessmentItemRefArray) {
            assrssref ++ ;
            [muArray addObject:model];
            NumberButton * bu = [[NumberButton alloc] initWithFrame:CGRectMake(5 + i%3*66.6, 0 + i/3*35, 61.6, 25)];
            bu.tag = 100 + i ;
            bu.index = (ASTIndex){partType,section,assrssref};
            [_scorView addSubview:bu];
            
//            [bu addTarget:self action:@selector(clickBu:) forControlEvents:BuTouchUpInside] ;
            i ++ ;
            
            [bu setTitle:[NSString stringWithFormat:@"%d",i] forState:BuNormal];
        }
    }
    
    NumberButton * button = [_scorView viewWithTag:100];
    [button setIsSelect:YES] ;
    
    _titleArray = muArray ;
    
    _scorView.contentSize = CGSizeMake(10,35 + i/3*35) ;
    
    
    [self next];
    
    
}


/*
- (void)clickBu:(UIButton *)bu
{
    for(int i = 0; i < _titleArray.count ; i++)
    {
        NumberButton * numBu = [_scorView viewWithTag:i + 100];
        if (bu == numBu) {
            [numBu setIsSelect:YES];
        }else
        {
            [numBu setIsSelect:NO];
        }
    }
    
    if (_ClickBlock) {
        _ClickBlock(_titleArray[bu.tag -100]) ;
    }
}
*/

- (void)next
{

    if (_buttonIndex > -1) {
        AssessmentItemRef * model = _titleArray[_buttonIndex] ;
        
        
        if (!model.userChoice && !model.userResDic) {
            [User setStatisticsWithAssessmentItemRef:model];
        }
        
    }
    
    _buttonIndex ++ ;
    
    NumberButton * numBu = [_scorView viewWithTag:_buttonIndex + 100];
    
    if(numBu)
    {
        [numBu setIsSelect:YES];

        if (_ClickBlock) {
            _ClickBlock(_titleArray[_buttonIndex]) ;
        }
    }
}


@end
