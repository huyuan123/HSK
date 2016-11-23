//
//  ExaminationsInforController.m
//  HSKExamination
//
//  Created by printer on 2016/10/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExaminationsInforController.h"
#import "User.h"
#import "PaperStructureController.h"
@interface ExaminationsInforController ()
{
    UIView  *   _backView ;
}
@end

@implementation ExaminationsInforController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBCOLOR(230, 221, 220) ;
    [self createView] ;
}

- (void)createView
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, screenWith(), screenHeight() - 20)];
    [self.view addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor];
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(40, 20, 43, 43)];
    [_backView addSubview:bu];
    [bu setNormalImage:[UIImage imageNamed:@"返回图标"]];
    [bu addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    
    NSString * text = @"一、 在考试开始前30分钟开始入场；在听力考试结束前到达考场的考生，可待阅读部分开始时参加考试，所误时间不补；在阅读考试开始后，迟到的考生不得进入考场参加考试。\n\n二、 考生进考场时须出示准考证和报名时提供的规定身份证件，身份证件上的姓名必须与准考证上登记的姓名完全一致，证件上的照片必须是可以确认的考生本人，即照片与本人面貌一致。进入考场后，考生须将准考证和身份证件放在桌子的右上方，以备主、监考随时检查。入场时无法提供规定证件或持任何假证件的考生，将被拒绝参加考试，不退还考试费用。\n\n三、 考试中途一般不得离场，如有特殊原因，考生需要中途离场，须经主考同意，在离开考场前把准考证交给主考官,考生返回考场需出示身份证件。\n\n四、 考试过程中不允许吃食品及饮用饮料；考试过程中，如果任何考生存在作弊行为，例如：替考、剽窃、抄袭、考试过程中夹带或偷看相关材料等，主考官有权拒绝考生继续考试，或记录在主考报告上，国家汉办有权取消其考试成绩，并保留拒绝该考生参加国家汉办/孔子学院总部所有考试的权利。\n\n五、 1）由于考场管理失误造成考生受到不公平待遇，例如：考试时间不足、考试设备故障等，导致考生无法完成考试，国家汉办将尽快安排考生免费重新参加考试，不承担任何间接损失补偿。\n            2）由于不可抗力，例如：自然灾害、意外事故，迫使考试无法进行，国家汉办将尽快安排重试，或全额退回考试费用，不承担任何间接损失补偿。\n\n六、 请考生认真按照步骤进行耳麦的调试，如有问题请即时向主考老师询问。作答书写题时，请严格按照答题纸上的要求进行作答。 " ;
    
    
    NSArray * arr = @[@"一、",@"二、",@"三、",@"四、",@"五、",@"六、",@"七、",];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    
    for(int i= 0 ; i < arr.count ; i++)
    {
        [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:arr[i]]];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:[text rangeOfString:arr[i]]];
    }
    
    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"1）"]];
    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"2）"]];

    
    NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc]init];
    style.headIndent = 50 ;
    [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
//    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:NSMakeRange(0,2)];
//    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"三、"]];
//    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"四、"]];
//    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"五、"]];
//    [str addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(120, 156, 0) range:[text rangeOfString:@"六、"]];


    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWith() - 225, 47, 115, 45)];
    label.backgroundColor = RGBCOLOR(120, 156, 0) ;
    [_backView addSubview:label];
    label.textColor = RGBCOLOR(96, 96, 96) ;
    label.text = [NSString stringWithFormat:@"HSK%@级",[User shareInstance].candiateModel.SubjectCode];
    label.textColor = [UIColor whiteColor];
    label.font = Font24 ;
    label.textAlignment = NSTextAlignmentCenter ;
    label.cornerRadius = 10 ;
    
    UIView * kuanView = [[UIView alloc] initWithFrame:CGRectMake(65, 85, screenWith() - 130, screenHeight() - 125)] ;
    [_backView addSubview:kuanView];
    kuanView.backgroundColor = [UIColor whiteColor];
    kuanView.layer.borderWidth = 2 ;
    kuanView.layer.borderColor = RGBCOLOR(120, 156, 0).CGColor ;
    kuanView.cornerRadius = 20 ;
    
    
    UILabel  * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 35, kuanView.width - 100, 3000)];
    textLabel.numberOfLines = 0 ;
    [kuanView addSubview:textLabel];
    textLabel.attributedText = str ;
    [textLabel sizeToFit];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [kuanView addSubview:button];
    button.center = CGPointMake(kuanView.middleX, kuanView.height -50 ) ;
    button.cornerRadius = 25 ;
    [button setTitle:@"下一步" forState:BuNormal] ;
    [button setBackgroundColor:RGBCOLOR(183, 223, 74)];
    
    [button addTarget:self action:@selector(buEvent) forControlEvents:BuTouchUpInside];

}

- (void)buEvent
{
    PaperStructureController * struMdoelCon = [[PaperStructureController alloc] init];
    [self.navigationController pushViewController:struMdoelCon animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
