//
//  FormalExaminationController.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "FormalExaminationController.h"
#import "ConfigureServerView.h"
#import "ServerController.h"
#import "NetWorking.h"
#import "Candidates.h"
@interface FormalExaminationController ()
{
    ConfigureServerView * _serView ;
    Candidates          * _candiModel ;
}
@end

@implementation FormalExaminationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createView];
}

- (void)longEvent:(UILongPressGestureRecognizer *)press
{
    if (press.state == UIGestureRecognizerStateEnded) {
        [self.view addSubview:[self serView]];
    }
}

- (ConfigureServerView *)serView
{
    if (!_serView) {
        _serView = [[ConfigureServerView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self ;
        __weak typeof(_serView) weakView = _serView ;
        [_serView setBlock:^{
            ServerController * con = [[ServerController alloc] init];
            [weakSelf.navigationController pushViewController:con animated:YES];
            [weakView removeFromSuperview];
        }] ;
    }
    
    return _serView ;
}

- (void)createView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(80, 176, 784, 490)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * backViw = [[UIView alloc] initWithFrame:CGRectMake(60,175, 825, 490)];
    backViw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backViw];
    backViw.cornerRadius = 20 ;
    
    //    backViw.layer.masksToBounds = YES ;
    view.layer.shadowOpacity = 0.5;// 阴影透明度
    
    view.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    
    view.layer.shadowRadius = 3;// 阴影扩散的范围控制
    
    view.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围

    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(225, 55, 375, 80)];
    [backViw addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    imageView.image = [UIImage imageNamed:@"logo"];
    imageView.userInteractionEnabled = YES ;
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longEvent:)];
    [imageView addGestureRecognizer:longTap];
    
    
    NSArray * arr = @[@"准考证号",@"考试密码"] ;
    for (int i = 0; i < 2; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(210, 200 + i*60, 80, 35)];
        [backViw addSubview:label];
        label.text = arr[i] ;
        label.textColor = RGBCOLOR(102, 102, 102) ;

        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(300, label.y, 320, 30)];
        [backViw addSubview:field];
        field.layer.borderColor = RGBCOLOR(217, 217, 217).CGColor;
        field.layer.borderWidth = 1 ;
        field.tag = 600 + i ;
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        field.leftView = v ;
        field.leftViewMode = UITextFieldViewModeAlways ;

    }
    
    
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [backViw addSubview:bu];
    bu.center = CGPointMake(backViw.middleX, backViw.middleY + 100 ) ;
    bu.cornerRadius = 25 ;
    [bu setTitle:@"进入考试" forState:BuNormal] ;
    [bu setBackgroundColor:RGBCOLOR(183, 223, 74)];
    
    [bu addTarget:self action:@selector(buEvent) forControlEvents:BuTouchUpInside];
}

- (void)buEvent
{

    NSString * count = [[self.view viewWithTag:600] text];
    NSString * password = [[self.view viewWithTag:601] text];

    if (!isCanUseString(count)) {
        Alert(@"请输入账号") ;
    }
    
    if (!isCanUseString(password)) {
        Alert(@"请输入密码") ;
    }
    
    NSDictionary * dic = @{@"examCode":count,@"password":password,@"mGuid":@"1"} ;
    
    dic = @{@"examCode":@"th6160389970010009",@"password":@"866456",@"mGuid":@"1"} ;
    
    [NetWorking postWithUrl:[[User shareInstance].serVerConfig[URLSerVer] stringByAppendingString: HskLogin] andParameter:dic andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
//        NSLog(@"%@",respon) ;
        NSDictionary * data = [NetWorking resoveData:respon];
        _candiModel = [[Candidates alloc] initWithDictionary:data];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }];
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
