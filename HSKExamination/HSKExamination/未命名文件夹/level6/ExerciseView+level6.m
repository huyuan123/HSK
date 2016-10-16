//
//  ExerciseView+level6.m
//  HSKExamination
//
//  Created by hiddy on 16/10/12.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level6.h"
#import "ItemBu.h"
@implementation ExerciseView (level6)

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
    
    if (model.media) {
        [self.manger playWithPath:model.media.src];
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
    
    
}

- (void)loadReadingComprehensionModel6:(ReadingComprehensionModel6 *)model
{
    UIScrollView * scoView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scoView];
    scoView.contentSize = CGSizeMake(10, model.subItemArray.count * 150 + 130) ;
    
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;
    NSDictionary * resDic = [modelRef userResDic];
    
    
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
    
    if (model.media) {
        [self.manger playWithPath:model.media.src];
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
}



- (void)loadSingle6:(SingleChoice6 *)model
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, self.backView.width - 60, 3000)];
    label.text = model.simpleModel.textString ;
    [self.backView addSubview:label];
    label.numberOfLines = 0 ;
    if (label.text.length < 20) {
        label.height = 30 ;
        label.textAlignment = CenterText ;

    }else
    {
        [label sizeToFit];
    }
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;

    
    NSArray * array = [model.simpleModel array];
    for (int i = 0; i < array.count ; i++) {
        SimpleChoice * choiceModel = array[i] ;
        ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(30, 260 + 65*i, 60, 30)];
        [self.backView addSubview:bu];
        [bu setImageName:@"点"];
        [bu setTitle:choiceModel.identifier forState:BuNormal];
        [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(90, bu.y +5 , 800, 100)];
        [self.backView addSubview:label];
        label.text = choiceModel.textString ;
        label.numberOfLines = 0 ;
        [label sizeToFit];
        
        [bu addTarget:self action:@selector(buSingChoiceEvent:) forControlEvents:BuTouchUpInside];
        
        if ([modelRef.userChoice isEqualToString:choiceModel.identifier]) {
            [bu setIsSelect:YES] ;
        }
    }
    
}


- (void)buSingChoiceEvent:(ItemBu *)bu
{
    NSArray * arr = [self.backView subviews];
    for (ItemBu * itemBu in arr) {
        if ([itemBu isKindOfClass:[ItemBu class]]) {
            [itemBu setIsSelect:NO];
        }
    }
    
    [bu setIsSelect:YES];
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.userChoice = bu.titleLabel.text ;
}
@end
