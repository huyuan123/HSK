//
//  PaperStructureController.m
//  HSKExamination
//
//  Created by printer on 2016/10/24.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "PaperStructureController.h"
#import "StructureModel.h"
#import "PersonInformationController.h"
@interface PaperStructureController ()
{
    StructureModel * _strucModel ;
    UIView  *   _backView ;
}
@end

@implementation PaperStructureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _strucModel = [[StructureModel alloc] init];
    [_strucModel parse];
    [self createView];
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
    
    UIScrollView * scroView = [[UIScrollView alloc] initWithFrame:kuanView.bounds];
    [kuanView addSubview:scroView];
    

        
    UIImageView * hearView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 35, 30, 30)];
    [scroView addSubview:hearView];
    hearView.contentMode = UIViewContentModeScaleAspectFit ;
    [hearView setImage:[UIImage imageNamed:@"听力图标-pre"]];
    
    UILabel * hearLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35, 50, 30)];
    hearLabel.textColor = RGBCOLOR(120, 156, 0) ;
    [scroView addSubview:hearLabel];
    hearLabel.text = @"听力" ;
    
    UILabel     *   hearContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 80, kuanView.width - 90, 3000)];
    [scroView addSubview:hearContentLabel];
    hearContentLabel.numberOfLines = 0 ;
    hearContentLabel.text = _strucModel.exam_head_string ;
    [hearContentLabel sizeToFit];
    hearContentLabel.textColor = RGBCOLOR(102, 102, 102)  ;
    
    UIView * readLine = [[UIView alloc] initWithFrame:CGRectMake(25, hearContentLabel.bottom + 30, kuanView.width - 50, 1)];
    readLine.backgroundColor = LineColor ;
    [scroView addSubview:readLine];
    
    
    UIImageView * hearView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, readLine.y + 20, 30, 30)];
    [scroView addSubview:hearView1];
    hearView1.contentMode = UIViewContentModeScaleAspectFit ;
    [hearView1 setImage:[UIImage imageNamed:@"阅读图标-pre"]];
    
    UILabel * hearLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(85, hearView1.y, 50, 30)];
    hearLabel1.textColor = RGBCOLOR(120, 156, 0) ;
    [scroView addSubview:hearLabel1];
    hearLabel1.text = @"阅读" ;
    
    UILabel     *   hearContentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(45, hearView1.bottom + 15, kuanView.width - 90, 3000)];
    [scroView addSubview:hearContentLabel1];
    hearContentLabel1.numberOfLines = 0 ;
    hearContentLabel1.text = _strucModel.exam_read_string ;
    [hearContentLabel1 sizeToFit];
    hearContentLabel1.textColor = RGBCOLOR(102, 102, 102)  ;
    
    UIView * readLine1 = [[UIView alloc] initWithFrame:CGRectMake(25, hearContentLabel1.bottom + 30, kuanView.width - 50, 1)];
    readLine1.backgroundColor = LineColor ;
    [scroView addSubview:readLine1];

    scroView.contentSize = CGSizeMake(10, readLine1.y + 80) ;
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [scroView addSubview:button];
    button.center = CGPointMake(kuanView.middleX, readLine1.y + 30 ) ;
    button.cornerRadius = 25 ;
    [button setTitle:@"下一步" forState:BuNormal] ;
    [button setBackgroundColor:RGBCOLOR(183, 223, 74)];
    
    [button addTarget:self action:@selector(buEvent) forControlEvents:BuTouchUpInside];

    
    if (_strucModel.exam_write_string.length) {
        
        UIImageView * hearView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, readLine1.y + 20, 30, 30)];
        [scroView addSubview:hearView2];
        hearView2.contentMode = UIViewContentModeScaleAspectFit ;
        [hearView2 setImage:[UIImage imageNamed:@"写作图标-pre"]];
        
        UILabel * hearLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(85, hearView2.y, 50, 30)];
        hearLabel2.textColor = RGBCOLOR(120, 156, 0) ;
        [scroView addSubview:hearLabel2];
        hearLabel2.text = @"书写" ;
        
        UILabel     *   hearContentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(45, hearView2.bottom + 15, kuanView.width - 90, 3000)];
        [scroView addSubview:hearContentLabel2];
        hearContentLabel2.numberOfLines = 0 ;
        hearContentLabel2.text = _strucModel.exam_write_string ;
        [hearContentLabel2 sizeToFit];
        hearContentLabel2.textColor = RGBCOLOR(102, 102, 102)  ;
        UIView * readLine2 = [[UIView alloc] initWithFrame:CGRectMake(25, hearContentLabel2.bottom + 30, kuanView.width - 50, 1)];
        readLine2.backgroundColor = LineColor ;
        [scroView addSubview:readLine2];
        
        scroView.contentSize = CGSizeMake(10, readLine2.y + 80) ;
        
        button.center = CGPointMake(kuanView.middleX, readLine2.y + 30 ) ;

    }

}

- (void)buEvent
{
    [self.navigationController pushViewController:[[PersonInformationController alloc] init]  animated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
