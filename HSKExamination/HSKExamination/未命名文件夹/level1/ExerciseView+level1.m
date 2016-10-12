//
//  ExerciseView+level1.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level1.h"
#import "ItemBu.h"
#import "SelectView.h"
@implementation ExerciseView (level1)
- (void)loadJudgeMent1:(Judgement1 *)judgeModel
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, judgeModel.img.width.floatValue, judgeModel.img.height.floatValue)];
    [self.backView addSubview:imageView];
    
    
    imageView.image = [UIImage imageWithContentsOfFile:judgeModel.img.src];
    CGPoint p = self.backView.middlePoint ;
    imageView.center = CGPointMake(p.x, p.y - 100) ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    

    CGRect rect = CGRectMake(0, imageView.bottom + 10, self.backView.width, 100) ;

    if (isCanUseString(judgeModel.textString)) {
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        [self.backView addSubview:label];
        label.textAlignment = CenterText ;
        label.font = judgeModel.img?Font24:Font18 ;
        label.numberOfLines = 0 ;
        label.text = [NSString stringWithFormat:@"%@\n%@",judgeModel.pinyinString,judgeModel.textString];
        label.textColor = [UIColor blackColor];
        
        rect = CGRectMake((self.backView.width -340)/2, imageView.bottom + 110, 340, 75) ;
    }else
    {
        rect = CGRectMake((self.backView.width -340)/2, imageView.bottom + 10, 340, 75) ;
    }
    
    
    
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

- (void)JudgementEvent:(UIButton *)bu
{
    for(int i = 0 ; i < 2 ; i++)
    {
        ItemBu * button = [self.backView viewWithTag:1000 +i];
        if (button == bu) {
            [button setIsSelect:YES];
        }else
        {
            [button setIsSelect:NO];
        }
    }
    
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    if (bu.tag == 1000) {
        model.userChoice = @"T" ;
    }else
    {
        model.userChoice = @"F" ;
    }
}


- (void)loadSingleChoice1:(SingleChoice1 *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    [self.backView addSubview:self.typeImageView];
    [self.backView addSubview:self.countLabel];
    self.countLabel.text = @"1/40" ;
    float x = (self.backView.width - 300)/4 ;
    
    if (choice.imgArr) {
        for (int i = 0; i < choice.imgArr.count; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i*(100 + x), 200, 100, 100)];
            [self.backView addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            imageView.image = [UIImage imageWithContentsOfFile:[choice.imgArr[i] src]];
            
            CGRect r = imageView.frame ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(r.origin.x , 300, 100, 100)];
            [self.backView addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:[choice.simpleChoiceArray[i] identifier]  forState:BuNormal];
            bu.titleLabel.font = [UIFont boldSystemFontOfSize:24] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.tag = 1000 + i ;
            [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            if (isCanUseString(model.userChoice)) {
                if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                    [bu setIsSelect:YES];
                }
            }
        }
        
    }else
    {
        x = (self.backView.width - 450)/4 ;
        for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + i*(150 + x), 220, 150, 100)];
            [self.backView addSubview:textLabel];
            //            textLabel.backgroundColor = [UIColor redColor];
            SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
            textLabel.numberOfLines = 0 ;
            textLabel.text = [choiceModel.pinYInString stringByAppendingString:@"\n"] ;
            textLabel.text = [textLabel.text stringByAppendingString:choiceModel.textString] ;
            textLabel.textAlignment = CenterText ;
            [textLabel adjustsFontSizeToFitWidth];
            
            CGRect r = textLabel.frame ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(r.origin.x , 300, 150, 100)];
            [self.backView addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:[choice.simpleChoiceArray[i] identifier]  forState:BuNormal];
            bu.titleLabel.font = [UIFont boldSystemFontOfSize:24] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.tag = 1000 + i ;
            [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            if (isCanUseString(model.userChoice)) {
                if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                    [bu setIsSelect:YES];
                }
            }
        }
        
    }
    
    
    
    if (choice.media) {
        [self.manger playWithPath:choice.media.src];
    }

}

- (void)singleChoiceEvent:(ItemBu *)bu
{
    
    NSArray * subArr = [self.backView subviews];
    for (ItemBu * view in subArr) {
        if (view == bu) {
            [view setIsSelect:YES];
        }else if([view isKindOfClass:[ItemBu class]])
        {
            [view setIsSelect:NO];
        }
    }
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.userChoice = bu.titleLabel.text ;
    
}



- (void)loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model
{
    
    if (model.imgArray.count) {
        
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
        
    }else if (model.topicArray.count)  // 阅读理解力没有图片的那种
    {
        for (int i = 0; i < model.topicArray.count  ; i++) {
            SimpleChoice * choice = model.topicArray[i] ;
            UILabel *  label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 170 + 60*i, 30, 30)];
            [self.backView addSubview:label1];
            label1.text = [model.topicArray[i] identifier] ;
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 170 + 60*i, 220, 40)];
            label.numberOfLines = 0 ;
            [self.backView addSubview:label];
            label.text = [choice.pinYInString stringByAppendingString:@"\n"] ;
            label.text = [label.text stringByAppendingString:choice.textString];
            [label adjustsFontSizeToFitWidth];
            label1.font = label.font = Font14 ;
        }
    }
    
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(270, 170 + 80*i, 380, 50)];
        if (modelref.userResDic && modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]]) {
            view.userRes =  modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]] ;
        }
        [self.backView addSubview:view];
        
        [view loadData:[model.subItemArr[i] array] andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
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
    
    if (modelref.astIndex.textPart == 1) {
        [self.manger playWithPath:model.media.src] ;
    }else
    {
        [self.manger stop];
    }

}

@end
