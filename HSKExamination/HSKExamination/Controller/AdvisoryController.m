//
//  AdvisoryController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AdvisoryController.h"
#import "StatisticalCenterController.h"
@interface AdvisoryController ()
{
    UIWebView * _webView ;
}
@end

@implementation AdvisoryController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [bu setTitle:@"统计中心" forState:BuNormal];
//    [self.view addSubview:bu];
//    bu.backgroundColor = [UIColor redColor];
//    [bu addTarget:self action:@selector(statisticalCenter) forControlEvents:BuTouchUpInside];
}

- (void)statisticalCenter
{
    [self.navigationController pushViewController:[[StatisticalCenterController alloc] init] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showContents
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:UrlString(@"http://cnhsk.org/hskpad")]];

}

- (void)hiddenContents
{
    
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

}

@end
