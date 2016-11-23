//
//  RealExerciseView+level4.m
//  HSKExamination
//
//  Created by printer on 2016/11/4.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "RealExerciseView+level4.h"
#import "SelectView.h"
#import "ItemBu.h"
@implementation RealExerciseView (level4)
- (void)loadSingleChoice4:(SingleChoice1 *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
//    model.correctResponse = choice.correctResponse ;
    
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
        x = (self.backView.width - 320)/3 ;
        for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(x + i%2* x*2 , 160 + i/2* 120, 60, 100)];
            [self.backView addSubview:bu];
            [bu setImageName:@"点"];
            [bu setTitle:[choice.simpleChoiceArray[i] identifier]  forState:BuNormal];
            bu.titleLabel.font = [UIFont boldSystemFontOfSize:24] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            bu.tag = 1000 + i ;
            [bu addTarget:self action:@selector(singleChoiceEvent:) forControlEvents:BuTouchUpInside];
            [bu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
            CGRect r = bu.frame ;
            
            
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(r.origin.x + r.size.width, r.origin.y, 150, 100)];
            [self.backView addSubview:textLabel];
            SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
            textLabel.numberOfLines = 0 ;
            //            textLabel.text = [choiceModel.pinYInString stringByAppendingString:@"\n"] ;
            textLabel.text = choiceModel.textString ;
            //            textLabel.textAlignment = CenterText ;
            
            //            textLabel.backgroundColor = [UIColor redColor];
            [textLabel adjustsFontSizeToFitWidth];
            
            if (isCanUseString(model.userChoice)) {
                if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                    [bu setIsSelect:YES];
                }
            }

            
        }
        
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
    
    
    if (entry.simpleChoiceArray.count) {
        for (int i = 0; i < entry.simpleChoiceArray.count; i++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(230,i *35+ 230, self.backView.width - 230, 20)];
            [self.backView addSubview:label];
            SimpleChoice * model = entry.simpleChoiceArray[i] ;
            label.text = [NSString stringWithFormat:@"%@.%@",model.identifier,model.textString];
        }

    }else
    {
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 230, self.backView.width - 250, 100)];
        textLabel.numberOfLines = 0 ;
        [self.backView addSubview:textLabel];
        textLabel.text = entry.textString ;
        [textLabel sizeToFit];
    }
    
    
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    textField.center = CGPointMake(self.backView.middleX, 385) ;
    [self.backView addSubview:textField];
    textField.cornerRadius = 25 ;
    textField.textAlignment = NSTextAlignmentCenter ;
    //    textField.backgroundColor = RGBCOLOR(188, 225, 84) ;
    textField.layer.borderWidth = 1 ;
    textField.layer.borderColor = RGBCOLOR(188, 225, 84).CGColor ;
    textField.delegate = self ;
    
    if (model.userChoice) {
        textField.text = model.userChoice ;
    }

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    model.userChoice = textField.text ;
    [User saveUserRes:model];
    return YES ;
}// return NO to not change text

- (void)loadExTendedText:(ExtendedText4 *)model
{
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    
    if (model.img) {
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        [self.backView addSubview:imageView];
        imageView.image = [UIImage imageWithContentsOfFile:model.img.src];
        
        imageView.center = self.backView.center ;
        imageView.y = 20 ;
    }
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 40)];
    [self.backView addSubview:textLabel];
    textLabel.text = [model.textString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    textLabel.numberOfLines = 0 ;
    textLabel.center = CGPointMake(imageView.centerX, imageView.bottom + 20) ;
    textLabel.textAlignment = CenterText ;
    
    if([User shareInstance].candiateModel.SubjectCode.intValue == 4)
    {
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 30)];
//        [self.backView addSubview:label];
//        label.text = @"看图,用词造句" ;
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(50, imageView.bottom + 30, self.backView.width - 100, 100)];
        [self.backView addSubview:textView];
        textView.delegate = self ;
        textView.cornerRadius = 10 ;
        textView.layer.borderWidth = 1 ;
        textView.layer.borderColor = LineColor.CGColor ;
        [textLabel sizeToFit];
        if (modelref.userChoice) {
            textView.text = modelref.userChoice ;
        }

    }else
    {
        if (model.img) {
            
            textLabel.frame = CGRectMake(100, imageView.bottom, self.backView.width -200, 300) ;
            [textLabel sizeToFit];
        }else
        {
            textLabel.frame = CGRectMake(50, 20, self.backView.width -100, 300) ;
            [textLabel sizeToFit];

        }
        
        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(50, textLabel.bottom + 20, self.backView.width - 100, 200)];
        [self.backView addSubview:textView];
        textView.delegate = self ;
        textView.cornerRadius = 10 ;
        textView.layer.borderWidth = 1 ;
        textView.layer.borderColor = LineColor.CGColor ;
        [textLabel sizeToFit];
        
        if (modelref.userChoice) {
            textView.text = modelref.userChoice ;
        }

    }
    
    
    if (model.img) {
        textLabel.centerX = imageView.centerX ;
    }
    
}

- (void)loadReadingComprehensionModel4:(ReadingComprehensionModel4 *)model 
{
    
    AssessmentItemRef * modelRef = (AssessmentItemRef *)self.assessection ;

    UIScrollView * scroView  = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    [self.backView addSubview:scroView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, self.backView.width - 100, 100)];
    label.textAlignment = CenterText ;
    [scroView addSubview:label];
    label.numberOfLines = 0 ;
    label.text = model.textString ;
    [label sizeToFit];
    
    NSArray * array = model.subItemArr ;
    NSArray * charaArray  =  @[@"A",@"B",@"C",@"D",@"E",@"F"] ;
    for (int i = 0; i < array.count; i++) {
        SimpleChoice * choice = array[i] ;
        UILabel * toplabel = [[UILabel alloc] initWithFrame:CGRectMake(50,80*i+ 200, self.backView.width -60, 25)];
        [scroView addSubview:toplabel];
        choice.textString = [choice.textString stringByReplacingOccurrencesOfString:@" " withString:@""] ;
        toplabel.text = [choice.textString stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;
        
        toplabel.text = [NSString stringWithFormat:@"%d. %@",i+1,toplabel.text];
        toplabel.adjustsFontSizeToFitWidth = YES ;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(50, toplabel.bottom, toplabel.width, 40)];
        [scroView addSubview:view];
        
        NSString * userChoice = [modelRef.userResDic objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        for (int j = 0; j < 6; j++) {
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(j * 60, 0, 40, 40)];
            [bu setImageName:@"点"];
            [bu setTitle:charaArray[j] forState:BuNormal];
            [view addSubview:bu];
            bu.tag = 100 + i ;
            bu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10) ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            [bu addTarget:self action:@selector(itemBuEvent:) forControlEvents:BuTouchUpInside] ;
            
            if ([userChoice isEqualToString:bu.titleLabel.text]) {
                [bu setIsSelect:YES];
            }
        }
        
        scroView.contentSize = CGSizeMake(10, 80*i + 300) ;
    }
    
}

@end
