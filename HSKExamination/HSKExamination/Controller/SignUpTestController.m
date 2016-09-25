//
//  SignUpTestController.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SignUpTestController.h"

@interface SignUpTestController ()  //  报名约考

@end

@implementation SignUpTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    label.font = Font24 ;
    label.textColor = [UIColor blackColor];
    label.text = @"我要约考" ;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
