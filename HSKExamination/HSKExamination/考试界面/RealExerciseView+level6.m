//
//  RealExerciseView+level6.m
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView+level6.h"
#import "ItemBu.h"
#import "NetWorking.h"
@implementation RealExerciseView (level6)
- (void)loadSingleChoice6:(SingleChoice1 *)model
{
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    for (int i = 0; i < model.simpleChoiceArray.count; i++) {
        ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(200, 150 + 40*i, 60, 30)];
        [self.backView addSubview:bu];
        [bu setImageName:@"点"];
        bu.tag = 100 + i ;
        [bu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(260, bu.y, 300, 30)];
        [self.backView addSubview:label];
        label.text = [model.simpleChoiceArray[i] textString] ;
        
        NSString * s =  [model.simpleChoiceArray[i] identifier] ;
        
        [bu setTitle:[@" " stringByAppendingString:s] forState:BuNormal];
        
        if ([bu.titleString isEqualToString:modelref.userChoice]) {
            [bu setIsSelect:YES];
        }
        [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
    }
    
}

- (void)buEvent:(ItemBu *)bu
{
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    for(int i = 0;i < 4 ; i ++)
    {
        ItemBu * but = [self.backView viewWithTag:100 + i];
        [but setIsSelect:NO];
    }
    
    [bu setIsSelect:YES];
    
    modelref.userChoice = bu.titleString ;
    [User saveUserRes:modelref];
}


- (void)loadReadingComprehensionModel6:(ReadingComprehensionModel6 *)model
{
    UIScrollView * scoView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scoView];
    scoView.contentSize = CGSizeMake(10, model.subItemArray.count * 150 + 130) ;
    
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;
    NSDictionary * resDic = [modelRef userResDic];
    modelRef.correctArr = model.correctResponseArray ;
    
    for (int i = 0; i < model.subItemArray.count; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + i * 150, self.backView.width -200, 120)];
        view.tag = 200 + i ;
        
        [scoView addSubview:view];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        label.text = [NSString stringWithFormat:@"%d",i +1];
        label.font = Font20 ;
        
        
        NSString * s = resDic[[NSString stringWithFormat:@"%ld",view.tag -200]] ;
        SimpleChoice * choice = model.subItemArray[i];
        for (int j = 0; j < choice.array.count; j++) {
            
            SimpleChoice * choiceModel = choice.array[j] ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(10, 30*j, 60, 30)];
            [bu setImageName:@"点"];
            [view addSubview:bu];
            [bu setTitle:[choiceModel identifier] forState:BuNormal];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            [bu addTarget:self action:@selector(buReadEvent:) forControlEvents:BuTouchUpInside];
            
            UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, bu.y , 200, 30)];
            [view addSubview:detailLabel];
            detailLabel.text = [choiceModel textString];
            
            if ([s isEqualToString:choiceModel.identifier]) {
                [bu setIsSelect:YES];
            }
        }
    }

}



- (void)buReadEvent:(ItemBu *)button
{
    UIView * supV = [button superview];
    NSArray * array = [supV subviews];
    for (ItemBu * view in array) {
        if ([view isKindOfClass:[ItemBu class]]) {
            [view setIsSelect:NO];
        }
        
    }
    [button setIsSelect:YES];
    
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    if (!model.userResDic) {
        model.userResDic = [NSMutableDictionary dictionary];
    }
    
    
    [model.userResDic setObject:button.titleLabel.text forKey:[NSString stringWithFormat:@"%ld",supV.tag -200]];
    
    [User saveUserRes:model];
}


- (void)loadSingle6:(SingleChoice6 *)model
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, self.backView.width - 60, 3000)];
    label.text = model.simpleModel.textString ;
    [self.backView addSubview:label];
    label.numberOfLines = 0 ;
    
//    if (label.text.length < 20) {
//        label.height = 40 ;
//        label.textAlignment = CenterText ;
        label.textColor = [UIColor redColor];
//    }else
    {
        [label sizeToFit];
    }
    
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;
    
    NSArray * array = [model.simpleModel array];
    for (int i = 0; i < array.count ; i++) {
        SimpleChoice * choiceModel = array[i] ;
        ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(30, label.bottom + 50 + 65*i, 60, 30)];
        [self.backView addSubview:bu];
        [bu setImageName:@"点"];
        [bu setTitle:choiceModel.identifier forState:BuNormal];
        [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
        bu.tag = 100 + i ;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(90, bu.y +5 , 500, 100)];
        [self.backView addSubview:label];
        label.text = choiceModel.textString ;
        label.numberOfLines = 0 ;
        [label sizeToFit];
        
        [bu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        
        if ([modelRef.userChoice isEqualToString:choiceModel.identifier]) {
            [bu setIsSelect:YES] ;
        }
    }
    
}

- (void)loadReadingComprehensionModel7:(ReadingComprehensionModel7 *)model
{
    UIScrollView * scor = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 3000)];
    label.numberOfLines = 0 ;
    [label setText:model.textString];
    [label sizeToFit];
    [scor addSubview:label];
    label.font = Font16 ;
    scor.contentSize = CGSizeMake(10, label.height + 70) ;
    
    
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;
    NSDictionary * resDic = [modelRef userResDic];
    
    for (int i = 0; i < model.subItemArray.count ; i++) {
        SimpleChoice * choiceModel = model.subItemArray[i] ;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(360,80 + i*160 , self.backView.width -370, 30)];
        [scor addSubview:label];
        
        label.text = [NSString stringWithFormat:@"%d %@",i+1,choiceModel.textString];
        label.adjustsFontSizeToFitWidth = YES ;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(360, 110 + i*160, label.width, 130)];
        [scor addSubview:view];
        view.tag = 200 + i ;
        
        NSString * s = resDic[[NSString stringWithFormat:@"%d",(int)view.tag -200]] ;
        
        for (int j = 0; j < choiceModel.array.count ; j++) {
            SimpleChoice * choice = choiceModel.array[j] ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(0, j * 30, 60, 30)];
            [bu setImageName:@"点"];
            [bu setTitle:choice.identifier forState:BuNormal];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [view addSubview:bu];
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            [bu addTarget:self action:@selector(buReadEvent:) forControlEvents:BuTouchUpInside];
            
            UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, bu.y, 200, 30)];
            [view addSubview:detailLabel];
            detailLabel.text = choice.textString ;
            detailLabel.adjustsFontSizeToFitWidth = YES ;
            if ([s isEqualToString:choice.identifier]) {
                [bu setIsSelect:YES];
            }
            
        }
    }

}

- (void)loadExtendedText:(ExtendedText *)model
{
    CGSize size = self.backView.bounds.size ;
    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height -20)];
    [self.backView addSubview:scroView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, size.width -200, 30000)];
    [scroView addSubview:label];
    label.numberOfLines = 0 ;
    label.font = Font16 ;
    label.textColor = [UIColor blackColor];
    label.text = model.textString ;
    [label sizeToFit];
    
    UITextView      *       textVIew = [[UITextView alloc] initWithFrame:CGRectMake(100, label.bottom + 30, label.width, 200)];
    [scroView addSubview:textVIew];
    textVIew.cornerRadius = 20 ;
    textVIew.layer.borderColor = [UIColor grayColor].CGColor ;
    textVIew.layer.borderWidth = 1 ;
    
    scroView.contentSize = CGSizeMake(10, label.height + 540) ;
    textVIew.delegate = self ;

}


- (void)loadCloze6:(Cloze6 *)model
{

}


@end
