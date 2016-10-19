//
//  ExerciseView+Read.m
//  HSKExamination
//
//  Created by hiddy on 16/10/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+Read.h"
#import "ItemBu.h"
#import "AssessmentItemRef.h"
#import "SelectView.h"
@implementation ExerciseView (Read)
#pragma mark------------------------------   加载判断题
//  加载判断题
- (void)loadReadJudgement:(Judgement *)judgeModel 
{

}

//- (void)JudgementEvent:(UIButton *)bu
//{
//    for(int i = 0 ; i < 2 ; i++)
//    {
//        ItemBu * button = [self.backView viewWithTag:1000 +i];
//        if (button == bu) {
//            [button setIsSelect:YES];
//        }else
//        {
//            [button setIsSelect:NO];
//        }
//    }
//    
//    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
//    if (bu.tag == 1000) {
//        model.userChoice = @"T" ;
//    }else
//    {
//        model.userChoice = @"F" ;
//    }
//}



- (void)loadReadReadModel:(ReadingComprehensionModel *)model
{
    /*
    [self.manger stop];
    
    float y = 170 ;
    
    for(int i = 0; i < model.imgArray.count ; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + i%2*120, y+i/2*135, 100, 115)];
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        imageView.image = [UIImage imageWithContentsOfFile:[model.imgArray[i] src]];
        [self.backView addSubview:imageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, 30, 30)];
        const char cha = i + 65 ;
        label.text = [NSString stringWithUTF8String:&cha] ;
        label.cornerRadius = 15 ;
        label.backgroundColor = RGBCOLOR(190, 226, 47) ;
        label.textColor = [UIColor whiteColor] ;
        [imageView addSubview:label];
        label.textAlignment = CenterText ;
        label.font = Font24 ;
    }
    
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(300, 170 + 80*i, 320, 50)];
        if (modelref.userResDic && modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]]) {
            view.userRes =  modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]] ;
        }
        [self.backView addSubview:view];
        
        [view loadData:model.subItemArr[i] andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
        [view setClickBlock:^(NSString * num, NSString * userRes) {
            if (modelref.userResDic == nil) {
                modelref.userResDic = [NSMutableDictionary dictionaryWithCapacity:5];
            }
            
            [modelref.userResDic setObject:userRes forKey:num];
        }];
    }
    */
}
@end
