//
//  ViewController.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
#import "TestPaperPackageInfoModel.h"
#import "SHXMLParser.h"
#import "ASTModel.h"
#import "NetWorking.h"
#import "AssessmentSection.h"
#import "assessmentItemRef.h"
#import "testPart.h"
#import "MainController.h"
#import "AdvisoryController.h"
#define ItemWith    230
#define ItemHeight  170

@interface ViewController ()

@end

@implementation ViewController
// 230x170
- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    [backView setImage:[UIImage imageNamed:@"底图.jpg"]];
    NSArray * arr = @[@"随身练习",@"考试咨询",@"报名约考",@"我要考试"] ;
    float x= (screenWith() - 50 - ItemWith*2)/2 ;
    float y = (screenHeight() - 30 - ItemHeight*2)/2 ;
    for (int i = 0; i < 4; i++) {
        UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(x + i%2*(ItemWith + 50), y + i/2*(ItemHeight+30) , ItemWith, ItemHeight)];
        [self.view addSubview:bu];
        bu.tag = 100 + i ;
//        [bu setTitle:arr[i] forState:BuNormal];
//        [bu setBackgroundColor:[UIColor redColor]];
        [bu setImage:[UIImage imageNamed:arr[i]] forState:BuNormal];
        [bu addTarget:self action:@selector(buevent:) forControlEvents:BuTouchUpInside];
    }
    
    [self homeBu];
    
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(90, self.homeBu.y , 350, 35)];
    imageview.contentMode = UIViewContentModeScaleAspectFit ;
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"首页logo"];
    
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 241, 52.5)];
    logoView.image = [UIImage imageNamed:@"首页log"];
    logoView.contentMode =  UIViewContentModeScaleAspectFit ;
    [self.view addSubview:logoView];
    
    logoView.centerX = self.view.width/2 ;
    logoView.centerY = screenHeight() - 50 ;
    
    
    BOOL b = [[UserDefault objectForKey:@"isHelp"] boolValue];
    
    if (!b) {
        UIButton * helpBu = [[UIButton alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:helpBu];
        [helpBu setImage:[UIImage imageNamed:@"1-HSK进入应用-帮助.jpg"] forState:BuNormal];
        [helpBu setImage:[UIImage imageNamed:@"1-HSK进入应用-帮助.jpg"] forState:UIControlStateHighlighted];

        [helpBu addTarget:self action:@selector(helpEvent:) forControlEvents:BuTouchUpInside];
        [UserDefault setObject:@YES forKey:@"isHelp"];
        [UserDefault synchronize] ;
        helpBu.tag = 100 ;
    }
}

- (void)helpEvent:(UIButton *)bu
{
    [bu removeFromSuperview];
}

- (void)buevent:(UIButton *)bu
{
    MainController * mainCon = [[MainController alloc] init];
    mainCon.selectIndex = (int)bu.tag -100 ;
    [self.navigationController pushViewController:mainCon animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
