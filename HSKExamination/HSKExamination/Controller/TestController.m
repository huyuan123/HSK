//
//  TestController.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TestController.h"
#import "TestController+PaperData.h"
#import "testPart.h"
#import "NumberView.h"
#import "ExerciseView.h"
#import "AssessmentSection.h"
#import "RightBu.h"
@interface TestController ()
{
    NumberView      *   _numberView ;
    ExerciseView    *   _exerView ;
}
@end

@implementation TestController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadExaDataWithLevel:_level];
    
    [self createView];
}

- (void)createView
{
    self.view.backgroundColor = RGBCOLOR(229, 220, 223) ;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenWith(), screenHeight() -100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

    UILabel * titleLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, screenWith(), 60)];
    [self.view addSubview:titleLevelLabel];
    titleLevelLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLevelLabel.text = [NSString stringWithFormat:@"HSK %d 级",_level];
    titleLevelLabel.textColor = RGBCOLOR(124, 109, 90) ;
    titleLevelLabel.textAlignment = CenterText ;
    
    self.homeBu.enabled = NO ;
    self.homeBu.y -= 20 ;
    CGRect rect = self.homeBu.frame ;
    UIButton * backBU = [[UIButton alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + 20, rect.origin.y, rect.size.width, rect.size.height)];
    [self.view addSubview:backBU];
    [backBU setImage:[UIImage imageNamed:@"返回图标"] forState:BuNormal];
    [backBU addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];

    
    [self createLeftView];
    [self createRightView];
}


- (void)createLeftView
{
    _numberView = [[NumberView alloc] initWithFrame:CGRectMake(30, 130, 205, screenHeight() -160)];
    [self.view addSubview:_numberView];    
    TestPart * part = _astModel.testPartArray[0];
    [_numberView loadTestPart:part];
}


- (void)createRightView
{
    _exerView = [[ExerciseView alloc] initWithFrame:CGRectMake(245, 130, screenWith() - 275, screenHeight() -160)];
    [self.view addSubview:_exerView];
    TestPart * part = _astModel.testPartArray[0];
    AssessmentSection * secModel = part.assessmentSectionArray[0] ;
    [_exerView loadAssMent:secModel.assessmentItemRefArray[0]];
    
    NSArray * arr = @[@"全部图标",@"听力图标",@"阅读图标",@"写作图标"];
    for (int i = 0; i < 4; i++) {
        RightBu * allBU = [[RightBu alloc] initWithFrame:CGRectMake(_exerView.width - 86, 50, 84, 120)];
        [_exerView addSubview:allBU];
        [allBU setImageName:arr[i]];
        [allBU setTitle:@"全部" forState:BuNormal];
        [allBU setTitleColor:[UIColor grayColor] forState:BuNormal];
        allBU.tag = 2000 + i ;
        
        if (i == 1) {
            [allBU setIsSelect:YES];
        }
        
        if (i > 0) {
            allBU.y = 275 + i *110 -110 ;
        }
        
        [allBU addTarget:self action:@selector(changgeTest:) forControlEvents:BuTouchUpInside];
    }
}

- (void)changgeTest:(UIButton *)bu  //  切换题目
{
    for (int i = 0; i < 4; i++) {
        RightBu * button = [_exerView viewWithTag:2000 + i];
        if (button == bu) {
            [button setIsSelect:YES];
        }else
        {
            [button setIsSelect:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
