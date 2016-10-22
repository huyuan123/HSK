//
//  ExerciseView+level4.m
//  HSKExamination
//
//  Created by hiddy on 16/10/9.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level4.h"
#import "ItemBu.h"
@implementation ExerciseView (level4)
- (void)loadSingleChoice4:(SingleChoice1 *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.correctResponse = choice.correctResponse ;
    [self.backView addSubview:self.typeImageView];
    [self.backView addSubview:self.countLabel];
    self.countLabel.text = @"1/40" ;
    
    
    float x = (self.backView.width - 400)/4 ;
    
    
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
        x = (self.backView.width - 400)/5 ;
        for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + i*(100 + x), 220, 100, 100)];
            [self.backView addSubview:textLabel];
            //            textLabel.backgroundColor = [UIColor redColor];
            SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
            textLabel.numberOfLines = 0 ;
            textLabel.text = [choiceModel.pinYInString stringByAppendingString:@"\n"] ;
            textLabel.text = [textLabel.text stringByAppendingString:choiceModel.textString] ;
            textLabel.textAlignment = CenterText ;
            [textLabel adjustsFontSizeToFitWidth];
            
            CGRect r = textLabel.frame ;
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
        
    }
    
    
    
    if (choice.media) {
        [self.manger playWithPath:choice.media.src];
    }
}


- (void)loadTextEntry:(TextEntry *)entry
{
    
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.correctResponse = entry.correctResponse ;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, self.backView.width, 30)];
    [self.backView addSubview:label];
    label.textColor = RGBCOLOR(188, 225, 84) ;
    label.text = @"将题干中的句子，排列顺序，组成一句完成的话" ;
    label.textAlignment = CenterText ;
    
    for (int i = 0; i < entry.simpleChoiceArray.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(230,i *35+ 230, self.backView.width - 230, 20)];
        [self.backView addSubview:label];
        SimpleChoice * model = entry.simpleChoiceArray[i] ;
        label.text = [NSString stringWithFormat:@"%@.%@",model.identifier,model.textString];
    }
    
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    textField.center = CGPointMake(self.backView.middleX, 385) ;
    [self.backView addSubview:textField];
    textField.cornerRadius = 25 ;
    textField.textAlignment = NSTextAlignmentCenter ;
    textField.backgroundColor = RGBCOLOR(188, 225, 84) ;
    
    textField.delegate = self ;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.userChoice = textField.text ;
    return YES ;
}// return NO to not change text


@end
