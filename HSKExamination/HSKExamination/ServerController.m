//
//  ServerController.m
//  HSKExamination
//
//  Created by hiddy on 16/10/22.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ServerController.h"
#import "ItemBu.h"
#import "NetWorking.h"
@interface ServerController ()
{
    UIView  *   _configSerView ;
    UIView  *   _backView ;
}

@end

@implementation ServerController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self createView];
}

- (void)createView
{
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(screenWith() - 100, 40, 80, 40)];
    [self.view addSubview:bu];
    [bu setTitle:@"配置" forState:BuNormal];
    bu.backgroundColor = [UIColor grayColor];
    [bu addTarget:self action:@selector(configSer) forControlEvents:BuTouchUpInside];
    
    UIButton * backBu = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    [self.view addSubview:backBu];
    [backBu setImage:[UIImage imageNamed:@"返回图标"] forState:BuNormal];
    [backBu addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    
}

- (void)createViewWithArr:(NSArray *)array
{
    [_backView removeFromSuperview];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, screenWith(), screenHeight())];
    [self.view addSubview:_backView];
    NSDictionary * dic = [User shareInstance].serVerConfig ;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 600, 30)];
    
    
    NSString * s = [NSString stringWithFormat:@"当前服务器地址:%@",dic[URLSerVer]] ;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:s];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[s rangeOfString:dic[URLSerVer]]];
    label.attributedText = str;


    [_backView addSubview:label];
    [_configSerView removeFromSuperview];
    
    
    for (int i = 0; i < 2; i++) {
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20 + i*400, 60, 100, 30)] ;
        [_backView addSubview:titleLable];
        titleLable.text = @"服务器地址" ;
        titleLable.textColor = [UIColor blueColor] ;

        if (i) {
            titleLable.text = @"考试计划" ;
        }
    }
    
    UILabel * bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 160, 40)];
    [_backView addSubview:bigLabel];
    bigLabel.text = @"服务器" ;
    bigLabel.font = [UIFont systemFontOfSize:24];
    
    
    User * user =  [User shareInstance] ;
    for (int i = 0; i < 3; i++) {
        UILabel * conLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130 + i*30, 400, 30)];
        [_backView addSubview:conLabel];
        if (i == 0) {
            
            NSString * type = user.middleServer.intValue == 10000?@"中央服务器":@"考点服务器";
            
            conLabel.text = [NSString stringWithFormat:@"类型: %@",type];
            
        }else if (i == 1)
        {
            conLabel.text = [NSString stringWithFormat:@"代码: %@",user.serVerConfig[ServerCode]] ;
        }else if (i == 2)
        {
            conLabel.text = [NSString stringWithFormat:@"地址: %@",user.serVerConfig[URLSerVer]] ;
        }
    }
    
    
    UIScrollView * scor = [[UIScrollView alloc] initWithFrame:CGRectMake(420, 90, 420, screenHeight() - 90-80)];
    [_backView addSubview:scor];
//    scor.backgroundColor = [UIColor redColor];
    scor.showsVerticalScrollIndicator = scor.showsHorizontalScrollIndicator = NO ;
    
    
    UIView * lineLeft = [[UIView alloc] initWithFrame:CGRectMake(400, 60, 1, screenHeight())];
    [_backView addSubview:lineLeft];
    
    UIView * lineRight = [[UIView alloc] initWithFrame:CGRectMake(scor.right + 20, 60, 1, screenHeight())];
    [_backView addSubview:lineRight];
    lineRight.backgroundColor =    lineLeft.backgroundColor = LineColor ;

    NSLog(@"%@",array) ;
    float width = scor.width ;
    
    NSArray * arr = @[@"ExamPlanName",@"ExamPlanCode",@"ExamPlanInfoID",@"BeginTime",@"EndTime"] ;
    NSArray * titleArr = @[@"",@"计划编码:",@"计划信息ID:",@"计划开始时间:",@"计划结束时间:"] ;
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dataDic = array[i] ;

//        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * 200, width, 40)];
//        nameLabel.text = [dataDic objectForKey:@"ExamPlanName"] ;
//        [scor addSubview:nameLabel];
        
        for (int j = 0; j < 5; j++) {
            UILabel * codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,i*200 +j*30 + 30 , width, 30)];
            [scor addSubview:codeLabel];
            codeLabel.text = [titleArr[j]  stringByAppendingString:[NSString stringWithFormat:@"%@",[dataDic  objectForKey:arr[j]]]]  ;
            
            if (j == 0) {
                codeLabel.y -= 20 ;
                codeLabel.font = [UIFont boldSystemFontOfSize:20] ;
            }

        }
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 200 * i+190, width, 1)];
        [scor addSubview:line];
        line.backgroundColor = LineColor ;
        scor.contentSize = CGSizeMake(10, line.y) ;
        
    }
}



- (void)configSer
{
    if (!_configSerView) {
        _configSerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _configSerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:_configSerView action:@selector(removeFromSuperview)];
        [_configSerView addGestureRecognizer:tap];
        
        
        UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWith()/2, 320)];
        [whiteView setBackgroundColor:[UIColor whiteColor]];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
        label.text = @"服务器配置" ;
        [_configSerView addSubview:whiteView];
        whiteView.center = _configSerView.middlePoint ;
        UITapGestureRecognizer * t = [[UITapGestureRecognizer alloc] initWithTarget:whiteView action:@selector(tag)];
        [whiteView addGestureRecognizer:t];
        whiteView.clipsToBounds = YES ;
        
        
        NSArray * arr = @[@"中央服务器",@"考点服务器"] ;
        for(int i = 0 ; i < 2 ;i++)
        {
            ItemBu * bu = [[ItemBu alloc] initWithFrame:CGRectMake(120 + 160 * i, 50, 30, 40)];
            [bu setImageName:@"点"];
            [whiteView addSubview:bu];
            
            UILabel * serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(bu.right , 50 , 100, 40)];
            [whiteView addSubview:serverLabel];
            serverLabel.text = arr[i] ;
            bu.tag = 10000 + i ;
            [bu addTarget:self action:@selector(selectSerVer:) forControlEvents:BuTouchUpInside];
        }
        
        NSArray * array = @[@"服务器:",@"地 址:",@"服务器代码:",];
        for (int i = 0; i < 3; i++) {
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90 + 60*i, 100, 40)];
            [whiteView addSubview:titleLabel];
            titleLabel.text = array[i] ;
            
            UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right + 10, 90 + 60 *i, 300, 30)];
            [whiteView addSubview:field];
            field.tag = 200 + i ;
            
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(field.x, field.bottom, screenWith(), 1)];
            line.backgroundColor = LineColor ;
            [whiteView addSubview:line];
        }
        
        NSArray  *  buArr = @[@"取消",@"配置"] ;
        
        for(int i = 0 ; i < 2 ; i ++)
        {
            UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake( i*whiteView.width/2, 260, whiteView.width/2, 40)];
            [bu setTitle:buArr[i] forState:BuNormal];
            [whiteView addSubview:bu] ;
            [bu setTitleColor:[UIColor blackColor] forState:BuNormal];
            
            [bu addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];
            bu.tag = 500 + i ;
//            bu.backgroundColor = [UIColor redColor];
            
        }
        
    }
    
    [self.view addSubview:_configSerView];
}

- (void)selectSerVer:(ItemBu *)bu
{
    [bu setIsSelect:YES];
    int i = bu.tag%2 == 0?1:-1 ;
    ItemBu * other =  [_configSerView viewWithTag:bu.tag + i];
    [other setIsSelect:NO] ;
    
    [User shareInstance].middleServer = [NSString stringWithFormat:@"%ld",bu.tag] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)buEvent:(UIButton *)buEvent
{
    User * u = [User shareInstance] ;
    
    if (buEvent.tag == 500) {
        [_configSerView removeFromSuperview];
    }else
    {

        UITextField * field1 = [_configSerView viewWithTag:200] ;
        UITextField * field2 = [_configSerView viewWithTag:201] ;
        UITextField * field3 = [_configSerView viewWithTag:202] ;
        
        if(!isCanUseString(u.middleServer))
        {
                Alert(@"请选择服务器") ;
            return ;
        }
        if (!isCanUseString(field1.text)) {
            Alert(@"请输入服务器") ;
            return ;

        }
        
        if (!isCanUseString(field2.text)) {
            Alert(@"请输入服务器地址") ;
            return ;

        }
        
        if (!isCanUseString(field3.text)) {
            Alert(@"请输入服务器代码") ;
            return ;

        }
        
        
        NSDictionary * dic = @{
                               MiddleServer :   u.middleServer,
                               Server       :   field1.text,
                               URLSerVer    :   field2.text,
                               ServerCode   :   field3.text
                               } ;

        
//                    dic = @{
//                               MiddleServer :   u.middleServer,
//                               Server       :   @"1",
//                               URLSerVer    :   @"http://mnks.cnhsk.org/MnMoblie/",
//                               ServerCode   :   @"20000013"
//                               } ;

        [u setSerVerConfig:dic];

        __weak typeof(self) weakSelf = self ;
        [NetWorking postWithUrl:[u.serVerConfig[URLSerVer] stringByAppendingString:HskServerTest] andParameter:@{@"examSiteID":u.serVerConfig[ServerCode]} andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
            
            NSArray * array =  [NetWorking resoveData:respon] ; // [d objectForKey:@"Data"];
            [weakSelf createViewWithArr:array];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error) ;
        }];
        
    }
}


@end
