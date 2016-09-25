//
//  SelectLevelController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "SelectLevelController.h"
#import "TestController.h"
@interface SelectLevelController ()

@property (nonatomic ,strong) UIImageView * selectBackView ;

@property (nonatomic ,strong) UIView * backView ;

@end

@implementation SelectLevelController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];
}

- (void)createView
{
    
    UIImageView * titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 350, 35)];
    [titleImage setImage:[UIImage imageNamed:@"首页logo"]];
    [self.view addSubview:titleImage];
    
    titleImage.contentMode = UIViewContentModeScaleAspectFit ;
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 170, 720, 490)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.cornerRadius = 20 ;
    CGPoint p = self.view.center ;
    view.center = CGPointMake(p.x -100, p.y) ;
    
    _backView = [[UIView alloc] initWithFrame:view.frame];
    [self.view addSubview:_backView];
    
    _selectBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 518)];
    _selectBackView.contentMode = UIViewContentModeScaleAspectFit ;
    _selectBackView.image = [UIImage imageNamed:@"选中色块"];
    _selectBackView.hidden = YES ;
    [_backView addSubview:_selectBackView] ;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, 130, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:40];
    titleLabel.textAlignment = CenterText ;
    [_selectBackView addSubview:titleLabel];
    titleLabel.textColor = RGBCOLOR(184, 223, 76) ;
    titleLabel.text = @"HSK" ;
    
    UILabel * levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 205, 130, 30)];
    [_selectBackView addSubview:levelLabel];
    levelLabel.font = Font20 ;
    [levelLabel setText:[NSString stringWithFormat:@"level 1"]];
    levelLabel.textAlignment = CenterText ;
    levelLabel.textColor = RGBCOLOR(184, 223, 76) ;
    levelLabel.tag = 10 ;
    
    
    UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, 130, 60)];
    detail.font = [UIFont systemFontOfSize:12] ;
    [_selectBackView addSubview:detail];
    detail.text = [NSString stringWithFormat:@"汉语考试-随身练习\n"];
    detail.textAlignment = CenterText ;
    detail.textColor = RGBCOLOR(184, 223, 76) ;
    
    for (int i = 0; i < 6; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + 120*i, 30, 80, 80)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i +1]];
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        [_backView addSubview:imageView];
        
        if (i != 5) {
            
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake((i+1) * 120, 30, 1, 440)];
        [view addSubview:line];
        line.backgroundColor = RGBCOLOR(189, 226, 84) ;
        
        }
        UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(i*120, 0, 120, view.height)];
        [_backView addSubview:bu];
        [bu addTarget:self action:@selector(selectLevel:) forControlEvents:BuTouchUpInside];
        [bu addTarget:self action:@selector(setSelect:) forControlEvents:UIControlEventTouchDown];
        bu.tag = 1000 +i ;
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 120, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:30] ;
        [bu addSubview:titleLabel];
        titleLabel.textColor = RGBCOLOR(133, 154, 53) ;
        titleLabel.text = @"HSK" ;
        titleLabel.textAlignment = NSTextAlignmentCenter ;

        UILabel * subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 430, 120, 30)];
        subtitleLabel.font = [UIFont systemFontOfSize:20] ;
        [bu addSubview:subtitleLabel];
        subtitleLabel.textColor = RGBCOLOR(133, 154, 53) ;
        subtitleLabel.text = [NSString stringWithFormat:@"( %d级 )",i+1] ;
        subtitleLabel.textAlignment = NSTextAlignmentCenter ;

        titleLabel.tag = 10 ;
        subtitleLabel.tag = 11 ;
    }
}

- (void)selectLevel:(UIButton *)bu
{
    _selectBackView.hidden = YES ;
    UILabel * l1 = [bu viewWithTag:10];
    UILabel * l2 = [bu viewWithTag:11];
    l1.textColor = l2.textColor = RGBCOLOR(133, 154, 53) ;

    TestController * testCon = [[TestController alloc] init];
    testCon.level = bu.tag - 999 ;
    [self.navigationController pushViewController:testCon animated:YES];
}

- (void)setSelect:(UIButton *)bu
{
    _selectBackView.hidden = NO ;
    _selectBackView.center = bu.center ;
    
    UILabel * l1 = [bu viewWithTag:10];
    UILabel * l2 = [bu viewWithTag:11];
    l1.textColor = l2.textColor = [UIColor whiteColor];
    
    UILabel * label =  [_selectBackView viewWithTag:10] ;
    label.text = [NSString stringWithFormat:@"level %d",bu.tag -999];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
