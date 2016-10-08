//
//  ExerciseView+level2.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level2.h"
#import "SelectView.h"
@implementation ExerciseView (level2)
- (void)loadReadingComprehensionModel2:(ReadingComprehensionModel2 *)model
{
    NSString * string = @"" ;

    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
    [self.backView addSubview:scro];
    
    for (int i = 0; i < model.topicArray.count; i++) {
//        string = [string stringByAppendingFormat:@"       \n%@",[model.topicArray[i] pinYInString]];
        string = [string stringByAppendingFormat:@"       %@",[model.topicArray[i] identifier]];
        string = [string stringByAppendingFormat:@" %@",[model.topicArray[i] textString]];
        
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.backView.width , 3000)];
    [scro addSubview:label];
    label.text = string ;
    
    label.textAlignment = CenterText ;
    
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
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(40, topicLabel.bottom -20, self.backView.width -40, 60)];
        
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
    
    scro.contentSize = CGSizeMake(10, y + model.subItemArr.count * 80) ;
    
}

@end
