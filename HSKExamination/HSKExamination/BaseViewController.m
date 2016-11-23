//
//  BaseViewController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES ;
}

- (void)createView{}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)homeBu
{
    if (!_homeBu) {
        _homeBu = [[UIButton alloc] initWithFrame:CGRectMake(35, 60, 42, 42)];
        [_homeBu setImage:[UIImage imageNamed:@"home"] forState:BuNormal];
        [self.view addSubview:_homeBu];
    }
    
    return _homeBu ;
}


@end
