//
//  MianController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "MainController.h"
#import "LeftSelectBu.h"
#import "AdvisoryController.h"
#import "SelectLevelController.h"
#import "SignUpTestController.h"
#import "FormalExaminationController.h"
@interface MainController ()
{
    UIWebView       *       _webView ;
}

@property (nonatomic ,strong) SelectLevelController         * selectCon ;
@property (nonatomic ,strong) AdvisoryController            * advisCon ;
@property (nonatomic ,strong) SignUpTestController          * signUpCon ;
@property (nonatomic ,strong) FormalExaminationController   * formaCom ;

@property (nonatomic ,strong) NSMutableArray                * controllers ;
@property (nonatomic ,strong) UIViewController              * currentCon ;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self createView];
}

- (void)createView
{
    UIImageView * backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    [backView setImage:[UIImage imageNamed:@"底图.jpg"]];
    NSArray * arr = @[@"左标随身",@"左标咨询",@"左标约考",@"左标考试"] ;

    [[self homeBu] addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    
    float y = (screenHeight() - 115*4 - 6)/2 ;
    
    for(int i = 0; i < 4; i++)
    {
        LeftSelectBu * bu = [[LeftSelectBu alloc] initWithFrame:CGRectMake(0, y + i*116, 90, 115)];
        [self.view addSubview:bu];
        [bu setImageName:arr[i]];
        bu.tag = 100 + i ;
        if (i == _selectIndex) {
            [bu setIsSelect:YES];
        }
        
        [bu addTarget:self action:@selector(changgeItem:) forControlEvents:BuTouchUpInside];
    }
    
    [self setSubController];
}

- (void)setSubController
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 0, screenWith() -100, screenHeight())];
    [self.view addSubview:view];
    
    _selectCon  = [[SelectLevelController alloc] init];
    _advisCon   = [[AdvisoryController alloc] init];
    _signUpCon  = [[SignUpTestController alloc] init];
    _formaCom   = [[FormalExaminationController alloc] init];
    _selectCon.view.frame = _advisCon.view.frame = _signUpCon.view.frame = _formaCom.view.frame = view.bounds ;
//
    [self addChildViewController:_selectCon];
    [self addChildViewController:_advisCon];
    [self addChildViewController:_signUpCon];
    [self addChildViewController:_formaCom];

    _controllers = [NSMutableArray arrayWithCapacity:4];
    [_controllers addObject:_selectCon];
    [_controllers addObject:_advisCon];
    [_controllers addObject:_signUpCon];
    [_controllers addObject:_formaCom];
    
    
    _currentCon = _controllers[_selectIndex] ;

    [view addSubview:[_controllers[_selectIndex] view]];

}

- (void)changgeItem:(UIButton *)but
{
    UIViewController * con = _controllers[but.tag-100];
    if (con == _currentCon) {
        return ;
    }
    
    for (int i = 0; i < 4; i++) {
        LeftSelectBu * bu = [self.view viewWithTag:100 + i];
        if (bu == but) {
            [bu setIsSelect:YES] ;
        }else
        {
            [bu setIsSelect:NO];
        }
    }
    
    [self transitionFromViewController:_currentCon toViewController:con duration:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        _currentCon = con ;
        if (_currentCon == _advisCon) {
            [_advisCon showContents];
        }else
        {
            [_advisCon hiddenContents];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"选择等级释放了------------------") ;
}

@end
