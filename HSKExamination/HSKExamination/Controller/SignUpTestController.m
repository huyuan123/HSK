//
//  SignUpTestController.m
//  HSKExamination
//
//  Created by hiddy on 16/9/24.
//  Copyright © 2016年 printer. All rights reserved.
//


#define CityUrl   @"http://mnks.cnhsk.org/hsk/api/examcenter"

#import "SignUpTestController.h"
#import "NetWorking.h"
#import "CityModel.h"
#import "CityPickView.h"
@interface SignUpTestController ()<UITextFieldDelegate>  //  报名约考
@property (nonatomic ,strong)  NSArray      *   cityArray ;
@end

@implementation SignUpTestController
{
    CityPickView    * _pickView ;
    TestCenter      * _center ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self createView];
    
    [self initData];
}

- (void)initData
{
    [NetWorking getWithUrl:CityUrl andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respos) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:respos options:NSJSONReadingMutableContainers error:nil];
        
        if(arr)
        {
            NSMutableArray * array = [NSMutableArray array];
            for (NSDictionary * dic in arr) {
                [array addObject:[[CityModel alloc] initWithDictionary:dic]];
            }
            
            _cityArray = array ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

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

    NSArray * arr = @[@"姓名",@"性别",@"年龄",@"所在考点",@"报考等级",@"联系电话",@"邮箱"];
    
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
            
            segView.tag = 1000 ;
            
            continue ;
        }

        
        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(150, 70 + 50*i, 320, 30)];
        [backViw addSubview:field];
        field.layer.borderColor = RGBCOLOR(217, 217, 217).CGColor;
        field.layer.borderWidth = 1 ;
        
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        field.leftView = v ;
        field.leftViewMode = UITextFieldViewModeAlways ;
        
        if (i == 2 || i == 5 || i== 4) {
            field.keyboardType = UIKeyboardTypeNumberPad ;
        }
        
        field.tag = 100 + i ;
        
        if (i == 3) {
            field.delegate = self ;
            field.font = Font12 ;
            
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

    NSString * name = [[self.view viewWithTag:100] text];

    NSString * level = [[self.view viewWithTag:104] text];
//    NSString * old = [[self.view viewWithTag:100] text];
    NSString * phone = [[self.view viewWithTag:105] text];
    NSString * email = [[self.view viewWithTag:106] text];

    UISegmentedControl * segView = [self.view viewWithTag:1000];
    
    int gender = (int)segView.selectedSegmentIndex + 1 ;
    
    if (!isCanUseString(name)) {
        [[[UIAlertView alloc] initWithTitle:@"请输入姓名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show] ;
    }
    
    if (!isCanUseString(level)) {
        [[[UIAlertView alloc] initWithTitle:@"请输入等级" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show] ;

    }

    if (!isCanUseString(phone)) {
        [[[UIAlertView alloc] initWithTitle:@"请输入电话" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show] ;

    }

    if (!isCanUseString(email)) {
        [[[UIAlertView alloc] initWithTitle:@"请输入邮箱" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show] ;

    }

    if (!_center) {
        [[[UIAlertView alloc] initWithTitle:@"请输入考点" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show] ;

    }

    [NetWorking postWithUrl:HskYueKao andParameter:@{@"nationality" : @"US",
                                                     @"username": name,
                                                     @"gender" : [NSString stringWithFormat:@"%d",gender],
                                                     @"city" : _center.centerId,
                                                     @"level":level,
                                                     @"phone": phone,
                                                     @"email" : email
                                                     } andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
                                                         
                                                         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息已经提交，请耐心等待。我们会通知最近的考点与您联系" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                                         
                                                         [alert show];

                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                         NSLog(@"--------------------++++++++++++++%@",error) ;
                                                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[self pickView] show];
    return NO ;
}// return NO to disallow editing.

- (CityPickView *)pickView
{
    if (!_pickView) {
        _pickView = [[CityPickView alloc] init];
        [self.view addSubview:_pickView];
        [_pickView loadData:_cityArray];
        [_pickView setBlock:^(TestCenter * model) {
            UITextField * field = [self.view viewWithTag:103];
            field.text = model.testCenter ;
            _center = model ;
        }];
    }
    return _pickView ;
}

@end
