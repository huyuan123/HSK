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
#import "AudioManger.h"
#import "StatisticalCenterController.h"
@interface TestController ()<AVAudioPlayerDelegate>
{
    NumberView      *   _numberView ;
    ExerciseView    *   _exerView ;      //  听力的view
    AudioManger     *   _audioManer ;
}
@end

@implementation TestController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self initAudio];
    
    [self loadExaDataWithLevel:_level];
    
    [self createView];
    
    [self createHelp];
}

- (void)createHelp
{
    BOOL b = [[UserDefault objectForKey:@"isTestHelp"] boolValue];
    
    if (!b) {
        UIButton * helpBu = [[UIButton alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:helpBu];
        [helpBu setImage:[UIImage imageNamed:@"2-HSK随身练习页面帮助.jpg"] forState:BuNormal];
        [helpBu setImage:[UIImage imageNamed:@"2-HSK随身练习页面帮助.jpg"] forState:UIControlStateHighlighted];
        
        [helpBu addTarget:self action:@selector(helpEvent:) forControlEvents:BuTouchUpInside];
        [UserDefault setObject:@YES forKey:@"isTestHelp"];
        [UserDefault synchronize] ;
        helpBu.tag = 100 ;
    }
}

- (void)helpEvent:(UIButton *)bu
{
    [bu removeFromSuperview];
}

- (void)initAudio
{
    _audioManer = [[AudioManger alloc] init];
    _audioManer.delegate = self ;
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

    if(_astModel.testPartArray.count > 0)
    {
        TestPart * part = _astModel.testPartArray[0];
        [_numberView loadTestPart:part];
    }

    UIImageView * iconView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWith() - 250, 30, 198, 43)];
    iconView.contentMode =  UIViewContentModeScaleAspectFit ;
    [self.view addSubview:iconView];
    iconView.image = [UIImage imageNamed:@"首页log"];
    iconView.centerX = self.view.width-180;
    iconView.centerY = 60 ;
    
}


- (void)createLeftView
{
    __weak typeof(self) weakSelf = self ;

    _numberView = [[NumberView alloc] initWithFrame:CGRectMake(30, 130, 205, screenHeight() -160) andBlock:^(AssessmentItemRef *itemRef) {
        [weakSelf loadAssessmentItemRef:itemRef];
    }];
    
    [self.view addSubview:_numberView];
    
    [_numberView setStatisBlock:^{
        [weakSelf toStatisticalCenterController];
    }] ;
}


- (void)toStatisticalCenterController
{
    StatisticalCenterController * con = [[StatisticalCenterController alloc] init];
    [_exerView.manger stop] ;
    [self.navigationController pushViewController:con animated:YES];
}

- (void)loadAssessmentItemRef:(AssessmentItemRef *)ref
{
        [_exerView loadAssMent:ref] ;
}


- (void)swipeGesture:(UISwipeGestureRecognizer *)p
{
    [_numberView next];
}

- (void)createRightView
{
    _exerView = [[ExerciseView alloc] initWithFrame:CGRectMake(245, 130,screenWith() - 275, screenHeight() -160)];
    _exerView.manger = _audioManer ;
    [self.view addSubview:_exerView];
    _exerView.delegate = self ;
    _numberView.countLabel = _exerView.countLabel ;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
    [_exerView addGestureRecognizer:swipeGesture];
    
    NSArray * arr = @[@"全部图标",@"听力图标",@"阅读图标",@"写作图标"];
    NSArray * titleArr = @[@"全部",@"听力",@"阅读",@"书写"] ;
    
    int count = 4 ;
    if (_level < 3) {
        count -- ;
    }
    for (int i = 0; i < count ; i++) {
        RightBu * allBU = [[RightBu alloc] initWithFrame:CGRectMake(_exerView.width - 86, 50, 84, 120)];
        [_exerView addSubview:allBU];
        [allBU setImageName:arr[i]];
        [allBU setTitle:titleArr[i] forState:BuNormal];
        [allBU setTitleColor:[UIColor grayColor] forState:BuNormal];
        allBU.tag = 2000 + i ;
        
        if (i == 0) {
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
    

    int index = 0 ;
    if (bu.tag == 2000) {
        [_numberView loadTestPart:_astModel.testPartArray[0]];
    }else if (bu.tag == 2001)
    {
        [_numberView loadTestPart:_astModel.testPartArray[1]];
        index = 1 ;
    }else if (bu.tag == 2002)
    {
        [_numberView loadTestPart:_astModel.testPartArray[2]];
        index = 2 ;
    }else if (bu.tag == 2003)
    {
        [_numberView loadTestPart:_astModel.testPartArray[3]];
    }

}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
//    [self next];
}

- (void)next
{
    [_numberView next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
    [_audioManer stop];
    NSLog(@"-----------------测试页面释放了") ;
}

@end
