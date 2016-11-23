//
//  SoundDebugViewController.m
//  HSKExamination
//
//  Created by printer on 2016/10/26.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "SoundDebugViewController.h"
#import "UIImageView+WebCache.h"
#import "NetWorking.h"
#import "SSZipArchive.h"
#import "ExaminationController.h"
#import "SoundDebugTestBackView.h"
@interface SoundDebugViewController ()
{
    UIView      *       _backView ;
    
    BOOL                _isDownLoad ;
}
@end

@implementation SoundDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isDownLoad = NO ;
    [self.view setBackgroundColor:RGBCOLOR(230, 221, 220)];
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
    kuanView.tag = 2012 ;
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(75, 95, 170, 220)];
    [kuanView addSubview:icon];
    icon.contentMode = UIViewContentModeScaleAspectFit ;
    
    NSDictionary    * dic = [User shareInstance].serVerConfig ;
    Candidates      * userModel = [User shareInstance].candiateModel ;
    
    [icon sd_setImageWithURL:UrlString([dic[URLSerVer] stringByAppendingPathComponent:[userModel.Photo substringFromIndex:1]])] ;
    
    UILabel * notelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, icon.bottom + 10, 170, 30)];
    [kuanView addSubview:notelabel];
    [notelabel setText:@"本人证件照"] ;
    notelabel.textAlignment = CenterText ;
    notelabel.textColor = RGBCOLOR(96, 96, 96) ;
    
    NSArray * array = @[@"姓        名 :",@"准考证号 :"] ;
    
    Candidates      *       canModel = [User shareInstance].candiateModel ;
    
    for(int i = 0; i < 2 ;i++)
    {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 425 + 20*i, 250, 20)];
        [kuanView addSubview:label];
        label.text = array[i] ;
        label.textColor = RGBCOLOR(66, 66, 66) ;
        if(i == 0)
        {
            label.text = [label.text stringByAppendingFormat:@" %@",canModel.ExamineeName];
        }else
        {
            label.text = [label.text stringByAppendingFormat:@" %@",canModel.ExamCardNo];
        
        }
        
        label.font = Font16 ;
    }
    
    
    [self createLine];

    UILabel * paperDownLoadlabel = [[UILabel alloc] initWithFrame:CGRectMake(410, 100, 200, 40)] ;
    [kuanView addSubview:paperDownLoadlabel];
    [paperDownLoadlabel setTextColor:RGBCOLOR(121, 151, 0)];
    paperDownLoadlabel.text = @"试卷下载"  ;
    paperDownLoadlabel.font = Font20 ;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(410, 140, 375, 25)];
    [view setBackgroundColor:RGBCOLOR(218, 218, 218)];
    [kuanView addSubview:view];
    
    UIView * progressView = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:progressView];
    progressView.backgroundColor = RGBCOLOR(190, 226, 47) ;
    progressView.width = 1 ;
    [self downLoadWithView:progressView];
    view.cornerRadius = 12.5 ;
    progressView.cornerRadius = 12.5 ;
    
    
    UILabel     *   soundTestlabel = [[UILabel alloc] initWithFrame:CGRectMake(410, 245, 200, 40)];
    [kuanView addSubview:soundTestlabel];
    soundTestlabel.textColor = RGBCOLOR(121, 151, 0) ;
    soundTestlabel.text = @"声音调试" ;
    soundTestlabel.font = Font20 ;
    
    [self soundDebug];
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [kuanView addSubview:button];
    button.center = CGPointMake(kuanView.middleX + 152, kuanView.height -100 ) ;
    button.cornerRadius = 25 ;
    [button setTitle:@"设备调试完成" forState:BuNormal] ;
    [button setBackgroundColor:RGBCOLOR(183, 223, 74)];
    
    [button addTarget:self action:@selector(buEvent:) forControlEvents:BuTouchUpInside];

}

- (void)downLoadWithView:(UIView *)view
{
    Candidates * canModel = [User shareInstance].candiateModel ;
   
    NSString * urlString = [User shareInstance].serVerConfig[URLSerVer];
    
    urlString = [urlString stringByAppendingPathComponent:[canModel.PaperPackageFile substringFromIndex:1]] ;
    
    CGFloat width = view.superview.width;
    
    [NetWorking downLoadWithUrl:urlString withProGress:^(NSProgress *downloadProgress) {
        
        float totol = downloadProgress.totalUnitCount/1.0 ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            view.width = width*downloadProgress.completedUnitCount*1.0/ totol;
        }) ;

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        NSString * zipPath = [filePath.absoluteString substringFromIndex:7] ;

        NSString * destinationPath = [@"TEST" pathWithType:Documents] ;
        

    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath overwrite:YES password:canModel.PaperPassword error:nil];
    
    _isDownLoad = YES ;

    [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];

    [self.navigationController pushViewController:[[ExaminationController alloc] init] animated:YES];
        
    }] ;
    
    
}


- (void)soundDebug
{
    UIView * view = [self.view viewWithTag:2012];
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(420, 360, 365, 40)];
    [view addSubview:slider];
    slider.maximumValue = 1 ;
    slider.minimumValue = 0 ;
    slider.value = 1 ;
    [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    [User shareInstance].audioManger = [[AudioManger alloc] init] ;
//    [User shareInstance].audioManger.repeatCount = -1 ;
    [[User shareInstance].audioManger playWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp3"]];
    
    SoundDebugTestBackView * soundView = [[SoundDebugTestBackView alloc] initWithFrame:CGRectMake(420, 300, 365, 40)];
    [view addSubview:soundView];
    soundView.tag = 400 ;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(305, 435, view.width - 305, 30)];
    [view addSubview:label];
    label.text = @"根据播放音量，调节耳机声音大小，如果音量大小已经调试完成，请点击\"设备调试完成\"按钮" ;
    label.textAlignment = CenterText ;
    [view addSubview:label];
    label.textColor = RGBCOLOR(171, 171, 171) ;
    label.font = Font12 ;
}

- (void)changeValue:(UISlider *)slider
{
    [User shareInstance].audioManger.soundMax = slider.value;
    SoundDebugTestBackView * soundView = [self.view viewWithTag:400];
    [soundView setVoluem:slider.value];
}

- (void)buEvent:(UIButton *)bu
{
    [bu setEnabled:NO];
    bu.backgroundColor = [UIColor grayColor] ;
    [[User shareInstance].audioManger stop] ;
    
    if (_isDownLoad) {
        [self.navigationController pushViewController:[[ExaminationController alloc] init] animated:YES];
    }
}

- (void)createLine
{
    CGRect frame = [self.view viewWithTag:2012].frame ;
    CGMutablePathRef path = CGPathCreateMutable() ;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:CGRectMake(0, 0, 1, frame.size.height -60)];
    [shapeLayer setPosition:CGPointMake(305, frame.size.height/2)];
    [shapeLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    //         设置虚线颜色为blackColor
    //         [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor grayColor] CGColor]];
    //         3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
    [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
    [NSNumber numberWithInt:3],nil]];
    // Setup the path CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0,frame.size.height -40);
    [shapeLayer setPath:path];
    [[self.view viewWithTag:2012].layer addSublayer:shapeLayer];
    CGPathRelease(path);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
