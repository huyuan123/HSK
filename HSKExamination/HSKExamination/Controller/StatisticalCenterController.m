//
//  StatisticalCenterController.m
//  HSKExamination
//
//  Created by hiddy on 16/10/18.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "StatisticalCenterController.h"

@interface StatisticalCenterController ()
{
    UIView * _backView ;
}
@end

@implementation StatisticalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];
}

- (void)createView
{
    self.view.backgroundColor = RGBCOLOR(229, 220, 223) ;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenWith(), screenHeight() -100)];
    [self.view addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor];

    
    UIButton * backBU = [[UIButton alloc] initWithFrame:CGRectMake(90, 40, 40 , 40)];
    [self.view addSubview:backBU];
    [backBU setImage:[UIImage imageNamed:@"返回图标"] forState:BuNormal];
    [backBU addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];

    CGFloat width = (screenWith() -220)/6 ;
    
    NSArray * arr = @[@"一级",@"二级",@"三级",@"四级",@"五级",@"六级"] ;
    for(int i = 0 ; i < 6 ; i++)
    {
        UIButton * bu =  [[UIButton alloc] initWithFrame:CGRectMake(60 + i*(width + 20), 20, width, 40)];
        [_backView addSubview:bu];
        [bu setTitleColor:RGBCOLOR(143, 170, 74) forState:BuNormal];
        
        bu.cornerRadius = 20 ;
        bu.layer.borderWidth = 2 ;
        bu.layer.borderColor = RGBCOLOR(143, 170, 74).CGColor ;
        [bu setTitle:arr[i] forState:BuNormal];
        [bu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
        
        bu.tag = 100 + i ;
    }
    
    [self buEvent:[_backView viewWithTag:100]];
    
    
    
}

- (void)loadBili
{
    [[_backView viewWithTag:10000] removeFromSuperview];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(60, 80, screenWith() -120, 550)];
    view.layer.borderColor = RGBCOLOR(143, 170, 74).CGColor ;
    view.layer.borderWidth = 2 ;
    [_backView addSubview:view];
    view.cornerRadius = 20 ;
    view.tag = 10000 ;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 50, 100, 30)];
    [view addSubview:titleLabel];
    titleLabel.textColor = RGBCOLOR(143, 170, 74) ;
    titleLabel.text = @"题目类型" ;
    titleLabel.font = [UIFont systemFontOfSize:20] ;
    
    
   NSArray * arr  = @[@"听力",@"阅读",@"写作"] ;
    for (int i = 0; i < 3; i++) {
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 145 + i*100, 30, 30)];
        [view addSubview:imageV];
        imageV.contentMode = UIViewContentModeScaleAspectFit ;
        [imageV setImage:[UIImage imageNamed:[arr[i] stringByAppendingString:@"图标-pre"]]];
        
        UIView * grayView = [[UIView alloc] initWithFrame:CGRectMake(235, imageV.y, 380, 25)];
        grayView.backgroundColor = [UIColor grayColor];
        [view addSubview:grayView];
        grayView.cornerRadius = 12.5 ;
        
        UIView * blueView = [[UIView alloc] initWithFrame:grayView.frame];
        [view addSubview:blueView];
        blueView.backgroundColor = RGBCOLOR(143, 170, 74) ;
        blueView.cornerRadius = 12.5 ;
        blueView.width = grayView.width/2 ;
        
        UILabel * biliLabel = [[UILabel alloc] initWithFrame:CGRectMake(grayView.right + 10, grayView.y, 100, 25)];
        [view addSubview:biliLabel];
        biliLabel.textColor =RGBCOLOR(143, 170, 74) ;
        biliLabel.text = @"70/70" ;
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(45, 435, view.width - 90, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];

}

- (void)buEvent:(UIButton *)button
{
    for(int i = 0 ; i < 6 ; i++ )
    {
        UIButton * bu = [_backView viewWithTag:100 + i];
        bu.layer.borderWidth = 2 ;
        bu.layer.borderColor = RGBCOLOR(143, 170, 74).CGColor ;
        [bu setTitleColor:RGBCOLOR(143, 170, 74) forState:BuNormal];
        bu.backgroundColor = [UIColor whiteColor];
    }
    button.layer.borderWidth = 0 ;
    button.layer.borderColor = RGBCOLOR(143, 170, 74).CGColor ;
    [button setTitleColor:[UIColor whiteColor] forState:BuNormal];
    button.backgroundColor = RGBCOLOR(143, 170, 74) ;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
