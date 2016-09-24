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
    NSArray * arr = @[@"左标随身",@"左标咨询",@"左标约考",@"左标考试"] ;
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
        NSString * norS = [NSString stringWithFormat:@"%@%@",arr[i],@"未选"];
        NSString * preS = [NSString stringWithFormat:@"%@%@",arr[i],@"选中"];
        [bu setNormalImage:[UIImage imageNamed:norS]];
        [bu setHighlightedImage:[UIImage imageNamed:preS]];
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
