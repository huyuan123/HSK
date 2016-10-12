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

@end
