//
//  MianController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "MainController.h"

@interface MainController ()
{
    UIWebView       *       _webView ;
}
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self createView];
}

- (void)createView
{
    NSArray * arr = @[@"随身练习",@"考试咨询",@"报名约考",@"我要考试"] ;
    UIButton * backBu = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [backBu setTitle:@"返回" forState:BuNormal];
    [backBu setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:backBu];
    [backBu addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    
    float y = (screenHeight() - 115*4 - 6)/2 ;
    
    for(int i = 0; i < 4; i++)
    {
        UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(0, y + i*116, 90, 115)];
        [self.view addSubview:bu];
        bu.backgroundColor = [UIColor redColor] ;
        [bu setTitle:arr[i] forState:BuNormal];
    }
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake( 100, 50, screenWith() -200, screenHeight() - 100)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor redColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:UrlString(@"http://www.cnhsk.org")]];
    
}

- (void)layoutSubViewWithIndex:(int)index
{

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
