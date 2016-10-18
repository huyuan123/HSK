//
//  AdvisoryController.m
//  HSKExamination
//
//  Created by printer on 9/22/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AdvisoryController.h"

@interface AdvisoryController ()
{
    UIWebView * _webView ;
}
@end

@implementation AdvisoryController

- (void)viewDidLoad {
    [super viewDidLoad];

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
