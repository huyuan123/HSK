//
//  ConfigureServerView.m
//  HSKExamination
//
//  Created by hiddy on 16/10/22.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ConfigureServerView.h"

#define UserName  @"admin"
#define PassWord  @"1234554321"

@implementation ConfigureServerView
{
    UIView  *   _loginView ;
}
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWith()/2, 300)];
        [self addSubview:_loginView];
        _loginView.backgroundColor = [UIColor whiteColor];
        _loginView.center = self.middlePoint ;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [self addGestureRecognizer:tap];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
        [_loginView addSubview:label];
        label.text = @"后台管理" ;
        UIView * line = CreateLine ;
        _loginView.clipsToBounds = YES ;
        line.frame  = CGRectMake(0, 50, screenWith(), 1) ;
        [_loginView addSubview:line];
        
        
        NSArray * arr = @[@"用户名: ",@"密   码: "] ;
        for (int i = 0; i < 2; i++) {
            UILabel * Tlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70 + i*60, 60, 40)];
            Tlabel.text = arr[i] ;
            [_loginView addSubview:Tlabel];
//            Tlabel.backgroundColor = [UIColor redColor];
            
            UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(90, Tlabel.y, 300, 30)];
            [_loginView addSubview:field];
            field.tag = 100 + i ;
            
            UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(90, field.bottom, screenWith(), 1)];
            lineV.backgroundColor = LineColor ;
            [_loginView addSubview:lineV];
        }
        
        NSArray * array = @[@"取消",@"登录"];
        
        for(int i = 0; i < 2 ; i++)
        {
            UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(i* _loginView.width/2, 210, _loginView.width/2, 60)];
            [bu setTitle:array[i] forState:BuNormal];
            [_loginView addSubview:bu];
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            [bu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
            bu.tag = 1000 + i ;
        }
        
    }
    
    return self ;
}

- (void)buEvent:(UIButton *)bu
{
    if (bu.tag == 1000) {
        [self removeFromSuperview];
    }else
    {
        /*
        UITextField * username = [_loginView viewWithTag:100];
        UITextField * passWord = [_loginView viewWithTag:101];
        if (!isCanUseString(username.text)) {
            [ShowHUD showOnlyCustomInfoWithString:@"请输入用户名" configParameter:^(ShowHUD *config) {
                
            } duration:2 inView:self];
            
        }else if (!isCanUseString(passWord.text))
        {
            [ShowHUD showOnlyCustomInfoWithString:@"请输入密码" configParameter:^(ShowHUD *config) {
                
            } duration:2 inView:self];

        }
        
        
      else  if ([username.text isEqualToString:UserName] && [passWord.text isEqualToString:PassWord]) {
         */
          if (_block) {
              _block() ;
          }
        
        /*
        }else
        {
            [ShowHUD showOnlyCustomInfoWithString:@"用户名或密码错误" configParameter:^(ShowHUD *config) {
                
            } duration:2 inView:self];

        }
         
         */
    }
}
@end
