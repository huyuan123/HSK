//
//  ExerciseView+level3.m
//  HSKExamination
//
//  Created by hiddy on 16/10/7.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExerciseView+level3.h"
#import "ItemBu.h"
#import "SelectView.h"
#import "WhriteBackView.h"
#import "WhriteItemView.h"
@implementation ExerciseView (level3)
- (void)loadJudgeMent3:(Judgement3 *)judgeModel
{
        CGRect rect = CGRectMake(60, 160, self.backView.width-120, 1000) ;
    
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        [self.backView addSubview:label];
        label.textAlignment = NSTextAlignmentLeft ;
        label.font = Font18 ;
        label.numberOfLines = 0 ;
        label.text = [NSString stringWithFormat:@"%@",judgeModel.textString];
        label.textColor = [UIColor blackColor];
    
        [label sizeToFit];

        rect = CGRectMake((self.backView.width -340)/2, label.bottom + 110, 340, 75) ;
    
    
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
    
    if(judgeModel.media)
    {
        [self.manger playWithPath:judgeModel.media.src];
    }
}



- (void)loadReadingComprehensionModel3:(ReadingComprehensionModel3 *)model
{
    NSString * string = @"" ;
    
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
    [self.backView addSubview:scro];
    
    for (int i = 0; i < model.topicArray.count; i++) {
        string = [string stringByAppendingFormat:@"%@",[model.topicArray[i] identifier]];
        string = [string stringByAppendingFormat:@" %@\n\n",[model.topicArray[i] textString]];
        
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, self.backView.width -200 , 3000)];
    [scro addSubview:label];
    label.text = string ;
    
    label.textAlignment = NSTextAlignmentLeft ;
    
    label.numberOfLines = 0 ;
    [label sizeToFit];
    
    
    NSArray * titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F"] ;
    
    AssessmentItemRef * modelref = (AssessmentItemRef *)self.assessection ;
    modelref.correctArr = model.correctResponseArray ;
    CGFloat y = label.bottom ;
    
    for (int i = 0; i < model.subItemArr.count; i++) {
        UILabel * topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,y + i*80 + 50, self.backView.width -80, 3000)];
        topicLabel.text = [model.subItemArr[i] textString] ;
        topicLabel.text = [[NSString stringWithFormat:@"%d. ",i +1] stringByAppendingString:topicLabel.text];
        [scro addSubview:topicLabel];
        topicLabel.numberOfLines = 0 ;
        [topicLabel sizeToFit] ;
        SelectView * view = [[SelectView alloc] initWithFrame:CGRectMake(40, topicLabel.bottom -20, self.backView.width -80, 60)];
        
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
            
            [User setStatisticsWithAssessmentItemRef:modelref andIndex:num];
        }];
        
        [view hiddenNumber];
        
    }
    
    scro.contentSize = CGSizeMake(10,50+ y + model.subItemArr.count * 80) ;
    
}


- (void)loadSingleChoice3:(SingleChoice3 *)choice
{
    AssessmentItemRef * model = (AssessmentItemRef *)self.assessection ;
    self.countLabel.text = @"1/40" ;
    
    model.correctResponse = choice.correctResponse ;
    float x = (self.backView.width - 300)/4 ;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.backView.width - 100, 1000)];
    [self.backView addSubview:label];
    label.numberOfLines = 0 ;
    label.text = choice.textString ;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    
    int count = (int)choice.simpleChoiceArray.count ;
    {
        if (count < 4) {
            x = (self.backView.width - 100*count)/(count +1) ;
            for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
                UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + i*(100 + x), 260, 100, 100)];
                [self.backView addSubview:textLabel];
                //            textLabel.backgroundColor = [UIColor redColor];
                SimpleChoice * choiceModel = choice.simpleChoiceArray[i] ;
                textLabel.numberOfLines = 0 ;
                textLabel.text = choiceModel.textString ;
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
        }else
        {
            x = (self.backView.width - 160*2)/(3) ;
            for (int i = 0; i < choice.simpleChoiceArray.count; i++) {
                
                ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(x + i%2* x*2 , 260 + i/2* 120, 60, 100)];
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
                textLabel.text = choiceModel.textString ;
//                textLabel.backgroundColor = [UIColor redColor];
//                textLabel.textAlignment = CenterText ;
                [textLabel adjustsFontSizeToFitWidth];
                
//                CGRect r = textLabel.frame ;

                if (isCanUseString(model.userChoice)) {
                    if ([model.userChoice isEqualToString:bu.titleLabel.text]) {
                        [bu setIsSelect:YES];
                    }
                }
            }
        
        }
        
  
        
    }
    
    
    
    if (choice.media) {
        [self.manger playWithPath:choice.media.src];
    }
}



- (void)loadOrder:(Order *)order
{
    
    WhriteBackView * backView = [[WhriteBackView alloc] initWithFrame:CGRectMake(20, 445, self.backView.width -40, 55)];
    backView.count = (int)order.subItemArray.count ;
    backView.cornerRadius = 10 ;
    [self.backView addSubview:backView];
    for (int i = 0; i < order.subItemArray.count; i++) {
        WhriteItemView * itemView = [[WhriteItemView alloc] init];
        [self.backView addSubview:itemView];
        itemView.text = order.subItemArray[i] ;
        
        CGFloat x = arc4random()%600 + 45 ;
        CGFloat y = arc4random()%300 + 100 ;
        itemView.center = CGPointMake(x, y) ;
        __weak typeof(backView) weakbackView = backView ;
        __weak typeof (itemView) weakItem = itemView ;
        [itemView setBlock:^{
            [weakbackView AdsorptionView:weakItem];
        }];
    }
}

- (void)loadTextEntry3:(TextEntry3 *)model
{
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 300, 30)];
    [self.backView addSubview:titleLabel];
    [titleLabel setText:@"请写出这句话缺少的字"];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, self.backView.width -200, 300)];
    [self.backView addSubview:label];
    label.text = model.textString ;
    label.numberOfLines = 0 ;
}


@end
