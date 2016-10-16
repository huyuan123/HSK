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
    [self initView];
    [self createView];
}

- (void)initView
{
    UIImageView * titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 350, 35)];
    [titleImage setImage:[UIImage imageNamed:@"首页logo"]];
    [self.view addSubview:titleImage];
    
    titleImage.contentMode = UIViewContentModeScaleAspectFit ;

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

    NSArray * arr = @[@"姓名",@"性别",@"年龄",@"所在城市",@"报考等级",@"联系电话",@"邮箱"];
    
    for (int i = 0; i < arr.count; i++) {
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(70, 70 + 50*i, 70, 30)];
        [backViw addSubview:label];
        label.text = arr[i] ;
        label.textAlignment = NSTextAlignmentRight ;
        label.textColor = RGBCOLOR(102, 102, 102) ;

        
        if (i == 1) {
            UISegmentedControl * segView = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]] ;
            
            segView.frame =    CGRectMake(150, 70 + 50*i, 70, 30);
            [backViw addSubview:segView];
            segView.selectedSegmentIndex = 0 ;
            
            continue ;
        }

        
        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(150, 70 + 50*i, 320, 30)];
        [backViw addSubview:field];
        field.layer.borderColor = RGBCOLOR(217, 217, 217).CGColor;
        field.layer.borderWidth = 1 ;
        
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        field.leftView = v ;
        field.leftViewMode = UITextFieldViewModeAlways ;
        
        if (i == 2 || i == 5) {
            field.keyboardType = UIKeyboardTypeNumberPad ;
        }
        
    }
    
    
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(565, 280, 200, 50)];
    [backViw addSubview:bu];
    [bu setTitle:@"提交" forState:BuNormal] ;
    [bu setBackgroundColor:RGBCOLOR(183, 223, 74)];
    bu.titleLabel.font = Font24 ;
    bu.cornerRadius = 25 ;

    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 110)];
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    [backViw addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"yk1"];
    
    imageView.center = CGPointMake(bu.centerX, bu.centerY - 150) ;
    
    
    [bu addTarget:self action:@selector(buEvent) forControlEvents:BuTouchUpInside];
}

- (void)buEvent
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息已经提交，请耐心等待。我们会通知最近的考点与您联系" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alert show];
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
