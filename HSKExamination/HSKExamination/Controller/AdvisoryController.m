//
//  AdvisoryController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AdvisoryController.h"
#import "StatisticalCenterController.h"
@interface AdvisoryController ()<UIWebViewDelegate>
{
    UIWebView       *       _webView ;
    ShowHUD         *       _showHud ;
}
@end

@implementation AdvisoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:UrlString(@"http://cnhsk.org/hskpad")]];
    _webView.delegate = self ;
    
    _showHud = [ShowHUD showText:@"正在加载..." configParameter:^(ShowHUD *config) {
        
    } inView:self.view];
}

- (void)statisticalCenter
{
    [self.navigationController pushViewController:[[StatisticalCenterController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showContents
{
//    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_webView];
//    [_webView loadRequest:[NSURLRequest requestWithURL:UrlString(@"http://cnhsk.org/hskpad")]];

}

- (void)hiddenContents
{
//    [_webView removeFromSuperview];
//    [[NSURLCache sharedURLCache] removeAllCachedResponses]  ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_showHud hide];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_showHud hide];
    Alert(@"请检查您的网络") ;
}


@end
