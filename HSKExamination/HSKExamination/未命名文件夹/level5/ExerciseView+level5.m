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
    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scroView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.backView.width -100, 1000)];
    label.text = model.textString ;
    label.numberOfLines = 0 ;
    [scroView addSubview:label];
    [label sizeToFit];
    
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SimpleChoice * modelChoice = model.subItemArr[i] ;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(90, 260 + i*160, self.backView.width - 60, 30)];
        [scroView addSubview:label];
        label.textColor = RGBCOLOR(190, 226, 47) ;
        label.text = modelChoice.textString ;
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(90, 310 + i*160, self.backView.width -180, 80)];
        [scroView addSubview:view];
        
        CGFloat width = view.width ;
        for (int j = 0; j < modelChoice.array.count; j++) {
            SimpleChoice * jModel = modelChoice.array[j] ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(j%2*width/2, j/2*40, 60, 30)];
            [view addSubview:bu];
            [bu setImageName:@"点"];
            bu.tag = 100 + i ;
            [bu setTitle:[NSString stringWithFormat:@"%@.",jModel.identifier] forState:BuNormal];
            bu.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20) ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
        
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
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 300, 3000)];
    label.numberOfLines = 0 ;
    [label setText:model.textString];
    [label sizeToFit];
    [scor addSubview:label];
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;

    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(360, 170 + 80*i, scor.width -370, 50)];
        if (modelref.userResDic && modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]]) {
            view.userRes =  modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]] ;
        }
        
        [self.backView addSubview:view];
        
        [view loadSubItem:[model.subItemArr[i] array] andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
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
    

}

@end
