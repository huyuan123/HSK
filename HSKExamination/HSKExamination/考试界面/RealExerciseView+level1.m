//
//  RealExerciseView+level1.m
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView+level1.h"
#import "ItemBu.h"
#import "SelectView.h"
@implementation RealExerciseView (level1)


- (void)loadJudgeMent1:(Judgement1 *)judgeModel
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, judgeModel.img.width.floatValue, judgeModel.img.height.floatValue)];
    [self.backView addSubview:imageView];
    
    
    imageView.image = [UIImage imageWithContentsOfFile:judgeModel.img.src];
    CGPoint p = self.backView.middlePoint ;
    imageView.center = CGPointMake(p.x, p.y - 100) ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
//    imageView.backgroundColor = [UIColor redColor];
//    NSLog(@"------------%@",judgeModel.img.src) ;
    
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
    model.correctResponse = judgeModel.correctResponse ;
    
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
    
}




- (void)loadSingleChoice1:(SingleChoice1 *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    float x = (self.backView.width - 300)/4 ;
    if (choice.imgArr) {
        for (int i = 0; i < choice.imgArr.count; i++) {
            UIButton * imageView = [[UIButton alloc] initWithFrame:CGRectMake(x + i*(100 + x), 200, 100, 100)];
            [self.backView addSubview:imageView];
//            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            
            Img    * img =  choice.imgArr[i] ;
//            imageView.image = [UIImage imageWithContentsOfFile:[img src]];
            [imageView setNormalImage:[UIImage imageWithContentsOfFile:[img src]]];
            [imageView setHighlightedImage:[UIImage imageWithContentsOfFile:[img src]]];
//            if (isCanUseString(img.width) && isCanUseString(img.height)) {
//                imageView.width = img.width.floatValue ;
//                imageView.height = img.height.floatValue ;
//            }
            
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
        x = (self.backView.width - 300)/4 ;
        for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + i*(50 + x), 120, 100, 100)];
            [self.backView addSubview:textLabel];
            SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
            textLabel.numberOfLines = 0 ;
            textLabel.text = [choiceModel.pinYInString stringByAppendingString:@"\n"] ;
            textLabel.text = [textLabel.text stringByAppendingString:choiceModel.textString] ;
            textLabel.textAlignment = CenterText ;
            [textLabel adjustsFontSizeToFitWidth];
            
            CGRect r = textLabel.frame ;
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(r.origin.x , 180, 50, 100)];
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
    
    model.correctResponse = choice.correctResponse ;
    
}





- (void)loadReadingComprehensionModel1:(ReadingComprehensionModel1 *)model
{

    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    scroView.showsVerticalScrollIndicator = scroView.showsHorizontalScrollIndicator = NO ;
    
    [self.backView addSubview:scroView];
    float y = 30 ;

    if (model.imgArray.count) {
        
        for(int i = 0; i < model.imgArray.count ; i++)
        {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + i%2*160, y+i/2*135, 150, 115)];
            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            imageView.image = [UIImage imageWithContentsOfFile:[model.imgArray[i] src]];
            [scroView addSubview:imageView];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, 30, 30)];
            const char cha = i + 65 ;
            label.text = [NSString stringWithUTF8String:&cha] ;
            label.cornerRadius = 15 ;
            label.backgroundColor = RGBCOLOR(190, 226, 47) ;
            label.textColor = [UIColor whiteColor] ;
            [imageView addSubview:label];
            label.textAlignment = CenterText ;
            label.font = Font24 ;
            
            if (i == 6) {
                imageView.width = 320 ;
            }
            scroView.contentSize = CGSizeMake(10, imageView.bottom + 50) ;
        }
        
    }else if (model.topicArray.count)  // 阅读理解力没有图片的那种
    {
        for (int i = 0; i < model.topicArray.count  ; i++) {
            SimpleChoice * choice = model.topicArray[i] ;
            UILabel *  label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, y + 60*i, 30, 30)];
            [scroView addSubview:label1];
            label1.text = [model.topicArray[i] identifier] ;
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 60*i, 220, 40)];
            label.numberOfLines = 0 ;
            [scroView addSubview:label];
            label.text = [choice.pinYInString stringByAppendingString:@"\n"] ;
            label.text = [label.text stringByAppendingString:choice.textString];
            [label adjustsFontSizeToFitWidth];
            label1.font = label.font = Font14 ;
        }
    }
    
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    
    for(int i = 0 ; i < model.subItemArr.count ; i++)
    {
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(360, y + 80*i, 380, 50)];
        if (modelref.userResDic && modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]]) {
            view.userRes =  modelref.userResDic[[NSString stringWithFormat:@"%d",i+1]] ;
        }
        [scroView addSubview:view];
        
        [view loadData:[model.subItemArr[i] array] andTitle:[NSString stringWithFormat:@"%d",i+1]];
        
        [view setClickBlock:^(NSString * num, NSString * userRes) {
            if (modelref.userResDic == nil) {
                modelref.userResDic = [NSMutableDictionary dictionaryWithCapacity:5];
            }
            
            [modelref.userResDic setObject:userRes forKey:num];
            [User saveUserRes:modelref];
        }];
        
        if (modelref.astIndex.textPart == 2) {
            [view loadsimpleChoice:model.subItemArr[i]];
        }
    }
    
}
@end
