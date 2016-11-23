//
//  PersonInformationController.m
//  HSKExamination
//
//  Created by printer on 2016/10/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "PersonInformationController.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "SoundDebugViewController.h"
@interface PersonInformationController ()

@end

@implementation PersonInformationController
{
    UIView      *       _backView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR(230, 221, 220)];
    [self createView];
}


- (void)createView
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, screenWith(), screenHeight() - 20)];
    [self.view addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor];
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(40, 20, 43, 43)];
    [_backView addSubview:bu];
    [bu setNormalImage:[UIImage imageNamed:@"返回图标"]];
    [bu addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWith() - 225, 47, 115, 45)];
    label.backgroundColor = RGBCOLOR(120, 156, 0) ;
    [_backView addSubview:label];
    label.textColor = RGBCOLOR(96, 96, 96) ;
    label.text = [NSString stringWithFormat:@"HSK%@级",[User shareInstance].candiateModel.SubjectCode];
    label.textColor = [UIColor whiteColor];
    label.font = Font24 ;
    label.textAlignment = NSTextAlignmentCenter ;
    label.cornerRadius = 10 ;
    
    UIView * kuanView = [[UIView alloc] initWithFrame:CGRectMake(65, 85, screenWith() - 130, screenHeight() - 125)] ;
    [_backView addSubview:kuanView];
    kuanView.backgroundColor = [UIColor whiteColor];
    kuanView.layer.borderWidth = 2 ;
    kuanView.layer.borderColor = RGBCOLOR(120, 156, 0).CGColor ;
    kuanView.cornerRadius = 20 ;
    
    UILabel * perLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0,screenWith() - 400 , 85)];
    perLabel.text = @"个人信息检索" ;
    perLabel.textColor = RGBCOLOR(115, 100, 80) ;
    [_backView addSubview:perLabel];
    perLabel.font = [UIFont boldSystemFontOfSize:30] ;
    perLabel.textAlignment = CenterText ;

    
    Candidates * userModel = [User shareInstance].candiateModel ;
    UIImageView * iconView = [[UIImageView alloc] initWithFrame:CGRectMake(165, 105, 170, 220)];
    [kuanView addSubview:iconView];
//    iconView.backgroundColor = [UIColor redColor];
    iconView.contentMode = UIViewContentModeScaleAspectFit ;
    
    NSDictionary    * dic = [User shareInstance].serVerConfig ;
    
    [iconView sd_setImageWithURL:UrlString([dic[URLSerVer] stringByAppendingPathComponent:[userModel.Photo substringFromIndex:1]])] ;
    
    NSArray * arr = @[@"姓       名 :",@"国       籍 :",@"性       别 :",@"证件号码 :",@"考试科目 :"];
    for(int i = 0 ; i < 5 ; i++)
    {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right + 100, 105 + 55*i, 350, 40)];
        [kuanView addSubview:label];
        label.textColor = RGBCOLOR(56, 56, 56) ;
        label.text = [arr[i] stringByAppendingString:@"         "] ;
        
        if(i == 0)
        {
            label.text = [label.text stringByAppendingString:userModel.ExamineeName] ;
        }else if (i == 1)
        {
            label.text = [label.text stringByAppendingString:userModel.Nationality] ;
        }else if (i == 2)
        {
            label.text = [label.text stringByAppendingString:[userModel.Sex intValue] == 1?@"男":@"女"] ;

        }else if (i == 3)
        {
            label.text = [label.text stringByAppendingString:userModel.ExamCardNo] ;

        }else if (i == 4)
        {
            label.text = [label.text stringByAppendingString:[NSString stringWithFormat:@"HSK%@级",userModel.SubjectCode]] ;

        }
    }
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [kuanView addSubview:button];
    button.center = CGPointMake(kuanView.middleX, kuanView.height -50 ) ;
    button.cornerRadius = 25 ;
    [button setTitle:@"确认" forState:BuNormal] ;
    [button setBackgroundColor:RGBCOLOR(183, 223, 74)];
    
    [button addTarget:self action:@selector(buEvent) forControlEvents:BuTouchUpInside];

    
}

- (void)buEvent
{
    [self.navigationController pushViewController:[[SoundDebugViewController alloc] init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
