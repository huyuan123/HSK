//
//  LeftSelectBu.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "LeftSelectBu.h"

@implementation LeftSelectBu
{
    UILabel     *       _nameLabel ;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName ;
    [super setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"未选"]] forState:BuNormal];
    [super setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"未选"]] forState:UIControlStateHighlighted];

    self.width = 60 ;
    
    //  @[@"左标随身",@"左标咨询",@"左标约考",@"左标考试"] ;
    
    if(!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 60, 50)];
        [self addSubview:_nameLabel];
        _nameLabel.textAlignment = CenterText ;
//        _nameLabel.adjustsFontSizeToFitWidth = YES ;
        _nameLabel.font = Font12 ;
    }
    
    if([imageName isEqualToString:@"左标随身"])
    {
        _nameLabel.text = @"随身练习" ;
    }else if ([imageName isEqualToString:@"左标咨询"])
    {
        _nameLabel.text = @"考试咨询" ;
    
    }else if ([imageName isEqualToString:@"左标约考"])
    {
        _nameLabel.text = @"报名约考" ;
    
    }else if ([imageName isEqualToString:@"左标考试"])
    {
        _nameLabel.text = @"我要考试" ;
    }
}

- (void)setIsSelect:(BOOL)b
{
    if (b) {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"点中"]] forState:BuNormal];
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"点中"]] forState:UIControlStateHighlighted];
        _nameLabel.width =   self.width = 90 ;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = Font14 ;

    }else
    {
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"未选"]] forState:BuNormal];
        [self setImage:[UIImage imageNamed:[_imageName stringByAppendingString:@"未选"]] forState:UIControlStateHighlighted];
        _nameLabel.textColor = [UIColor blackColor];
        
        _nameLabel.width = self.width = 60 ;
        _nameLabel.font = Font12 ;


    }
}

@end
