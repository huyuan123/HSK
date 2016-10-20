//
//  ExerciseView+level5.m
//  HSKExamination
//
//  Created by printer on 2016/10/11.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level5.h"
#import "ReadingComprehensionModel5.h"
#import "ItemBu.h"
#import "SelectView.h"
@implementation ExerciseView (level5)
- (void)loadReadingComprehensionModel5:(ReadingComprehensionModel5 *)model
{
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;
    modelRef.correctArr = model.correctResponseArray ;
    model.textString = [model.textString stringByReplacingOccurrencesOfString:@"rsquo;" withString:@"" ];
    model.textString = [model.textString stringByReplacingOccurrencesOfString:@"lsquo;" withString:@"" ];

    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scroView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.backView.width -100, 3000)];
    label.text = model.textString ;
    label.numberOfLines = 0 ;
    [scroView addSubview:label];
    [label sizeToFit];
    
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SimpleChoice * modelChoice = model.subItemArr[i] ;
        
        UILabel * tiHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, label.bottom + 40 + i*160, 600, 30)];
        [scroView addSubview:tiHaoLabel];
        tiHaoLabel.font = [UIFont boldSystemFontOfSize:20];
        tiHaoLabel.text = [NSString stringWithFormat:@"%d.%@",i+1,modelChoice.textString];
        tiHaoLabel.textColor = [UIColor blackColor];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(90, tiHaoLabel.bottom + 20, self.backView.width -180, 80)];
        [scroView addSubview:view];
        
        CGFloat width = view.width ;
        view.tag = 100 + i ;
        for (int j = 0; j < modelChoice.array.count; j++) {
            SimpleChoice * jModel = modelChoice.array[j] ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(j%2*width/2, j/2*40, 60, 30)];
            [view addSubview:bu];
            [bu setImageName:@"点"];
            bu.tag = 100 + i ;
            [bu setTitle:[NSString stringWithFormat:@"%@.",jModel.identifier] forState:BuNormal];
            bu.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20) ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            [bu addTarget:self action:@selector(clozeEvent:) forControlEvents:BuTouchUpInside];
        
            UILabel * ll = [[UILabel alloc] initWithFrame:CGRectMake(bu.right, bu.top, view.width/2, 30)];
            ll.text = jModel.textString ;
            [view addSubview:ll];
            ll.textColor = [UIColor blackColor] ;
        }
        
        scroView.contentSize = CGSizeMake(10, view.bottom + 10 );
    }
    
    if(model.media)
    {
        [self.manger playWithPath:model.media.src];
    }
}


- (void)loadCloze:(Cloze *)model
{
    UIScrollView * scor = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, 270, 3000)];
    label.numberOfLines = 0 ;
    [label setText:model.textString];
    [label sizeToFit];
    [scor addSubview:label];
    label.font = Font16 ;
    scor.contentSize = CGSizeMake(10, label.height + 170) ;
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    modelref.correctArr = model.correctResponseArray ;
    
    float height = 0 ;
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        UILabel * tiHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 120 + i*150, scor.width -390, 30)];
        [scor addSubview:tiHaoLabel];
        tiHaoLabel.text = [NSString stringWithFormat:@"%d",i + 1];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(360, 150 + i*150, scor.width - 390, 120)];
        [scor addSubview:view];
        height = view.bottom ;
        view.tag = 100 + i ;
        
        SimpleChoice * choice = [model.subItemArr objectAtIndex:i];

        for (int j = 0; j < choice.array.count; j++) {
            SimpleChoice * choiceModel = choice.array[j] ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(0, 30*j, 60, 30)];
            [view addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:choiceModel.identifier forState:BuNormal];
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0) ;
            
            UILabel * topLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, bu.y, 200, 30)];
            [view addSubview:topLabel];
            topLabel.text = choiceModel.textString ;
            [bu addTarget:self action:@selector(clozeEvent:) forControlEvents:BuTouchUpInside];
            
        }
    }
    
    scor.contentSize = CGSizeMake(10, label.bottom>height?label.bottom:height + 30) ;

}

- (void)clozeEvent:(ItemBu *)bu
{
    NSArray * arr = [bu.superview subviews];
    for (ItemBu * button in arr) {
        if ([button isKindOfClass:[ItemBu class]]) {
            [button setIsSelect:NO];
        }
    }
    
    [bu setIsSelect:YES];
    
    NSString * text  = bu.titleLabel.text ;
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;

    if (!modelref.userResDic) {
        modelref.userResDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    NSString * num = [NSString stringWithFormat:@"%ld",bu.superview.tag -99];
    
    if (modelref.correctResponse) {
        [User setStatisticsWithAssessmentItemRef:modelref];
    }else
    {
    
        [modelref.userResDic setObject:text forKey:num];
        [User setStatisticsWithAssessmentItemRef:modelref andIndex:num];
    }
}




#pragma mark--------------加载单选
- (void)loadSingleChoice5:(SingleChoice3 *)model
{
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    modelref.correctResponse = model.correctResponse ;
    
    model.textString = [model.textString stringByReplacingOccurrencesOfString:@"rdquo;" withString:@"" ];
    model.textString = [model.textString stringByReplacingOccurrencesOfString:@"ldquo;" withString:@"" ];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.backView.width - 100, 3000)];
    [self.backView addSubview:label];
    label.text = model.textString ;
    label.numberOfLines = 0 ;
    [label sizeToFit];
    
    for (int i = 0; i < model.simpleChoiceArray.count; i++) {
        ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(100, label.bottom + 50 + 30*i, 60, 30)];
        [bu setImageName:@"点"];
        SimpleChoice * cM = [model.simpleChoiceArray objectAtIndex:i];
        [self.backView addSubview:bu];
        [bu setTitle:cM.identifier forState:BuNormal];
        bu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0) ;
        [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
        
        UILabel * tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, bu.y, 400, 30)];
        [self.backView addSubview:tiLabel];
        [tiLabel setText:cM.textString];
        
        [bu addTarget:self action:@selector(clozeEvent:) forControlEvents:BuTouchUpInside];
    }
}

@end
