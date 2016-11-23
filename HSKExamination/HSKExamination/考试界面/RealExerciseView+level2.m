//
//  RealExerciseView+level2.m
//  HSKExamination
//
//  Created by hiddy on 16/11/5.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView+level2.h"
#import "SelectView.h"
@implementation RealExerciseView (level2)
- (void)loadReadingComprehensionModel2:(ReadingComprehensionModel2 *)model
{
    
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scro];
    

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, model.img.width.floatValue, model.img.height.floatValue)];
    [scro addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    imageView.image = [UIImage imageWithContentsOfFile:model.img.src];
    
    UIImageView * examView = [[UIImageView alloc] initWithFrame:CGRectMake(50, imageView.bottom + 30, model.exampleImg.width.floatValue, model.exampleImg.height.floatValue)];
    [scro addSubview:examView];
    examView.contentMode = UIViewContentModeScaleAspectFit ;
    examView.image = [UIImage imageWithContentsOfFile:model.exampleImg.src];
    
    NSArray * titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F"] ;
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    CGFloat y = examView.bottom + 30 ;
    
    for (int i = 0; i < model.subItemArr.count; i++) {
        SimpleChoice * simModel = model.subItemArr[i] ;
        UIImageView * topicLabel = [[UIImageView alloc] initWithFrame:CGRectMake(40,y , simModel.img.width.floatValue ,simModel.img.height.floatValue)];
        topicLabel.contentMode = UIViewContentModeScaleAspectFit ;
        topicLabel.image = [UIImage imageWithContentsOfFile:simModel.img.src];
        [scro addSubview:topicLabel];

        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 30,40)];
        [scro addSubview:titleLabel];
        titleLabel.text = [NSString stringWithFormat:@"%d.",i+1];
        
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(40, topicLabel.bottom-20 , self.backView.width -40, 60)];
        
        y = view.bottom + 20 ;
        
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
            [User saveUserRes:modelref];
        }];
        
        [view hiddenNumber];
        
    }
    
    scro.contentSize = CGSizeMake(10, y ) ;
    
}

@end
