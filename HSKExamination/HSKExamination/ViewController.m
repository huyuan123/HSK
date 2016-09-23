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
{
    TestPaperPackageInfoModel * _model ;
    SHXMLParser                 * parser ;
    ASTModel * model ;
}
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
