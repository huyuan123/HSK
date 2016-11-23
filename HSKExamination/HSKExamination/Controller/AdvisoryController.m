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

}

- (void)statisticalCenter
{
    [self.navigationController pushViewController:[[StatisticalCenterController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    [NetWorking getWithUrl:@"http://www.baidu.com" andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respos) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    [[NSURLCache sharedURLCache] removeAllCachedResponses]  ;
}

@end
