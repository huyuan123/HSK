//
//  ExerciseView+level3.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level3.h"
#import "ItemBu.h"
#import "SelectView.h"
@implementation ExerciseView (level3)
- (void)loadJudgeMent3:(Judgement3 *)judgeModel
{
        CGRect rect = CGRectMake(60, 160, self.backView.width-120, 1000) ;
    
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        [self.backView addSubview:label];
        label.textAlignment = NSTextAlignmentLeft ;
        label.font = Font18 ;
        label.numberOfLines = 0 ;
        label.text = [NSString stringWithFormat:@"%@",judgeModel.textString];
        label.textColor = [UIColor blackColor];
    
        [label sizeToFit];

        rect = CGRectMake((self.backView.width -340)/2, label.bottom + 110, 340, 75) ;
    
    
    UIView * view = [[UIView alloc] initWithFrame:rect];
    [self.backView addSubview:view];
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
    
    
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    
    if (isCanUseString(model.userChoice)) {
        if ([model.userChoice isEqualToString:@"T"]) {
            ItemBu * bu = [self.backView viewWithTag:1000];
            [bu setIsSelect:YES];
        }else
        {
            ItemBu * bu = [self.backView viewWithTag:1001];
            [bu setIsSelect:YES];
        }
    }
    
    if(judgeModel.media)
    {
        [self.manger playWithPath:judgeModel.media.src];
    }
}



- (void)loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model
{
    NSString * string = @"" ;
    
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
    [self.backView addSubview:scro];
    
    for (int i = 0; i < model.topicArray.count; i++) {
        //        string = [string stringByAppendingFormat:@"       \n%@",[model.topicArray[i] pinYInString]];
        string = [string stringByAppendingFormat:@"%@",[model.topicArray[i] identifier]];
        string = [string stringByAppendingFormat:@" %@\n\n",[model.topicArray[i] textString]];
        
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, self.backView.width -200 , 3000)];
    [scro addSubview:label];
    label.text = string ;
    
    label.textAlignment = NSTextAlignmentLeft ;
    
    label.numberOfLines = 0 ;
    [label sizeToFit];
    
    
    NSArray * titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F"] ;
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    CGFloat y = label.bottom ;
    
    for (int i = 0; i < model.subItemArr.count; i++) {
        UILabel * topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,y + i*80 + 50, self.backView.width -80, 3000)];
        topicLabel.text = [model.subItemArr[i] textString] ;
        topicLabel.text = [[NSString stringWithFormat:@"%d. ",i +1] stringByAppendingString:topicLabel.text];
        [scro addSubview:topicLabel];
        topicLabel.numberOfLines = 0 ;
        [topicLabel sizeToFit] ;
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(40, topicLabel.bottom -20, topicLabel.width, 60)];
        
        NSString * userRes = [modelref.userResDic objectForKey:[NSString stringWithFormat:@"%d",i+1]] ;
        if (isCanUseString(userRes)) {
            view.userRes = userRes  ;
        }
        
        [scro addSubview:view];
        [view loadData:titleArray andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
        
        [view setClickBlock:^(NSString * num, NSString * select) {
            if (!modelref.userResDic) {
                modelref.userResDic =  [NSMutableDictionary dictionary] ;
            }
            
            [modelref.userResDic setObject:select forKey:num];
        }];
        
        [view hiddenNumber];
        
    }
    
    scro.contentSize = CGSizeMake(10,50+ y + model.subItemArr.count * 80) ;
    
}


@end
