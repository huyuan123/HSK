//
//  ExaminationController.m
//  HSKExamination
//
//  Created by printer on 2016/10/28.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExaminationController.h"
#import "UIImageView+WebCache.h"
#import "ExaminationNumberView.h"
#import "PaperModel.h"
#import "AudioManger.h"
#import "TestNoteView.h"
#import "RealExerciseView.h"
#import "NetWorking.h"
#import "AgainExamModel.h"
@interface ExaminationController ()<AVAudioPlayerDelegate>
{
    UIView                  *       _backView ;
    ExaminationNumberView   *       _numberView ;
    PaperModel              *       _papaerModel ;
    AudioManger             *       _manger ;
    ASTIndex                        _soundIndex ;
    TestNoteView            *       _testNoteView ;
    RealExerciseView        *       _exerciseView ;
}

@end

@implementation ExaminationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLabel];
    [self paresePaper];

    [self.view addSubview:[self backButton]];
    [self createView];

}

- (void)initLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWith() - 225, 55, 115, 45)];
    label.backgroundColor = RGBCOLOR(120, 156, 0) ;
    [self.view addSubview:label];
    label.textColor = RGBCOLOR(96, 96, 96) ;
    label.text = [NSString stringWithFormat:@"HSK%@级",[User shareInstance].candiateModel.SubjectCode];
    label.textColor = [UIColor whiteColor];
    label.font = Font24 ;
    label.textAlignment = NSTextAlignmentCenter ;
    label.cornerRadius = 10 ;
    _soundIndex = (ASTIndex){1,0,0} ;
    //    _soundIndex = (ASTIndex){1,4,6} ;

}

- (void)paresePaper
{
    __weak typeof(self) weakSelf = self ;
    _papaerModel = [[PaperModel alloc] init];
    
    [_papaerModel setCompleteBlock:^{
        [weakSelf playMeadia];
    }];
    
    [_papaerModel parseInPath:nil];

}

- (void)createShaperLine
{
    CGRect frame = _backView.frame ;
    CGMutablePathRef path = CGPathCreateMutable() ;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:CGRectMake(0, 0, 1, frame.size.height -40)];
    [shapeLayer setPosition:CGPointMake(290, frame.size.height/2)];
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
    [_backView.layer addSublayer:shapeLayer];
    CGPathRelease(path);
    
}

- (void)playMeadia
{
    if (!_manger) {
        _manger = [[AudioManger alloc] init] ;
        _manger.delegate = self ;
    }
    
    
    AgainExamModel * model = [User shareInstance].againModel ;
    
    if (!model) {
        TestPart * part = _papaerModel.testPartArray[0];
        [_manger playWithPath: part.rubricBlock.src];
    }else
    {
        [_numberView setTestPart:1];
        _soundIndex.textPart = model.CurrentPartIndex.intValue + 1 ;
        _soundIndex.assessmentSection = model.CurrentSectionIndex.intValue + 1;
        _soundIndex.assessmentItemRef = model.CurrentItemIndex.intValue +1 ;
//        TestPart * part = _papaerModel.testPartArray[_soundIndex.textPart -1] ;
//        AssessmentSection * sec = part.assessmentSectionArray[_soundIndex.assessmentSection -1];
        [GCDQueue executeInMainQueue:^{
            if(_soundIndex.textPart == 1)
            {
                [self timeEnd];
            }else
            {
                _soundIndex.assessmentItemRef = 1 ;
                [_testNoteView setClockStringWithSec:model.CurrentPartRemainTime.intValue];
                [_numberView setTestPart:_soundIndex.textPart];
                [_numberView setSelectBuWithIndex:_soundIndex];
                
            }

            [_testNoteView.endButton setTitle:@"提交试卷" forState:BuNormal];

        } afterDelaySecs:0.5];

    }
    
//    [_testNoteView startTime];
}

- (UIButton *)backButton
{
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 43, 43)];
    [bu setNormalImage:[UIImage imageNamed:@"返回图标"]];
    [bu addTarget:self action:@selector(back) forControlEvents:BuTouchUpInside];
    return bu ;
}

- (void)createView
{
    
    self.view.backgroundColor = RGBCOLOR(226, 217, 220) ;

    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, screenWith(), screenHeight() -95)];
    [self.view addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor] ;
    [self createUserInforView];
    [self createNumberView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 35, screenWith() - 800, 60)];
    titleLabel.textAlignment = CenterText ;
    [self.view addSubview:titleLabel];
    titleLabel.textColor = RGBCOLOR(123, 106, 83) ;
    titleLabel.font = [UIFont boldSystemFontOfSize:28] ;
    titleLabel.text = @"正式考试" ;
    [self createShaperLine];
    [self createTestNoteView];
    [self createExaninaTionView];
}


- (void)createTestNoteView
{
    _testNoteView = [[TestNoteView alloc] initWithFrame:CGRectMake(300, 25, _backView.width - 310, 80)];
    [_backView addSubview:_testNoteView];
    _testNoteView.paperModel = _papaerModel ;

    __weak typeof(self) weakSelf = self ;
    [_testNoteView setNextBlock:^{
        [weakSelf timeEnd] ;
    }];

//    __weak typeof(self) weakSelf = self ;
    [_testNoteView setHearBackBlock:^(int index) {
        if (index == 1) {
            [weakSelf hearBack];
        }else if (index == 2)
        {
            [weakSelf nextPart];
        }else if (index == 10)
        {
            [weakSelf subMitPaper];
        }
    }];
}


- (void)subMitPaper
{
    int level  = [User shareInstance].candiateModel.SubjectCode.intValue ;
    
    if (level < 3) {
        TestPart * part = _papaerModel.testPartArray[1] ;
        AssessmentSection * sec = part.assessmentSectionArray.lastObject ;
        [self saveResPonseWithIndex:(ASTIndex){2,part.assessmentSectionArray.count,sec.assessmentItemRefArray.count}];
    }else
    {
        TestPart * part = _papaerModel.testPartArray[2] ;
        AssessmentSection * sec = part.assessmentSectionArray.lastObject ;
        [self saveResPonseWithIndex:(ASTIndex){3,part.assessmentSectionArray.count,sec.assessmentItemRefArray.count}];
    }
    
    __weak typeof(self) weakSelf = self ;
    [NetWorking postWithUrl:SavePaper andParameter:@{@"examCode":[User shareInstance].candiateModel.ExamCardNo} andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
        NSLog(@"提交试卷成功") ;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }];
}

- (void)hearBack
{
    TestPart  * part = _papaerModel.testPartArray[0];
    [_manger playWithPath:part.endBlock.src] ;
    [_testNoteView hearBackWithTime:part.timeLimit.checkTime.intValue];
    
    _soundIndex.assessmentSection = part.assessmentSectionArray.count +2 ;
    AssessmentSection * sec = part.assessmentSectionArray.lastObject ;
    _soundIndex.assessmentItemRef = sec.assessmentItemRefArray.count +1 ;
    
    Candidates * canModel = [User shareInstance].candiateModel;
    
    
    [self saveResPonseWithIndex:(ASTIndex){1,part.assessmentSectionArray.count,sec.assessmentItemRefArray.count}];
    
    [NetWorking postWithUrl:EndHearTest andParameter:@{
                                                       @"examCode"      :canModel.ExamCardNo,
                                                       @"itemId":@"",
                                                       @"lastPartIndex":   @(0),
                                                       @"lastSectionIndex":@(0),
                                                       @"lastItemIndex" :@(0),
                                                       @"LastProgress" :  @"3",
                                                       @"isExample"   :   @"0"
                                                       } andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
        NSLog(@"结束听力成功") ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }];
}


- (void)createExaninaTionView
{
    _exerciseView = [[RealExerciseView alloc] initWithFrame:CGRectMake(300, 120, screenWith() - 320, _backView.height -130)];
    [_backView addSubview:_exerciseView];

    __weak typeof(self) weakSelf = self ;
    [_exerciseView setBlock:^(BOOL b) {
        [weakSelf setIsNext:b];
    }] ;
}


- (void)setIsNext:(BOOL)b
{
    ASTIndex  index = _exerciseView.index ;
    TestPart  * part = _papaerModel.testPartArray[index.textPart -1];
    AssessmentSection * asection = part.assessmentSectionArray[index.assessmentSection -1] ;
    
    
    if (b) {
        
        if (index.assessmentItemRef < asection.assessmentItemRefArray.count) {
            index.assessmentItemRef ++ ;
            [_numberView nextWithIndex:index] ;

        }else if(index.assessmentSection < part.assessmentSectionArray.count)
        {
            index.assessmentSection ++ ;
            index.assessmentItemRef = 1 ;
            asection = part.assessmentSectionArray[index.assessmentSection -1] ;
            [_numberView nextWithIndex:index] ;

        }else
        {
            [[[UIAlertView alloc] initWithTitle:@"已经是最后一题" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
    }else
    {
        if (index.assessmentItemRef > 1) {
            index.assessmentItemRef -- ;
            [_numberView nextWithIndex:index] ;
            
        }else if(index.assessmentSection > 1)
        {
            index.assessmentSection -- ;
            
            asection = part.assessmentSectionArray[index.assessmentSection -1] ;

            index.assessmentItemRef = asection.assessmentItemRefArray.count ;
            [_numberView nextWithIndex:index] ;
            
        }else
        {
            [[[UIAlertView alloc] initWithTitle:@"已经是第一题" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
            
        }

    }
}


- (void)createUserInforView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 245, 135)];
    view.backgroundColor = RGBCOLOR(189, 225, 47) ;
    [_backView addSubview:view];
    view.cornerRadius = 20 ;
    
    UIImageView * userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 70, 90)];
    userIcon.contentMode = UIViewContentModeScaleAspectFit ;
    [view addSubview:userIcon] ;

    Candidates      * userModel = [User shareInstance].candiateModel ;
    NSDictionary    * dic = [User shareInstance].serVerConfig ;
    
    [userIcon sd_setImageWithURL:UrlString([dic[URLSerVer] stringByAppendingPathComponent:[userModel.Photo substringFromIndex:1]])] ;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, userIcon.bottom , 70, 20)];
    [view addSubview:label];
    label.text = @"本人证件照" ;
    label.font = Font10 ;
    label.textAlignment = CenterText ;
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.right + 10, 10, 150, 100)];
    [view addSubview:nameLabel];
    nameLabel.font = Font12 ;
    nameLabel.numberOfLines = 0 ;
    nameLabel.text = [NSString stringWithFormat:@"姓名\n%@\n\n准考证号\n%@",userModel.ExamineeName,userModel.ExamCardNo] ;

}

- (void)createNumberView
{
    _numberView = [[ExaminationNumberView alloc] initWithFrame:CGRectMake(20, 150, 245, _backView.height -165)];
    [_backView addSubview:_numberView];
    [_numberView initData];
    __weak typeof(self) weakSelf = self ;
    [_numberView setClickBlock:^(NumberButton * bu) {
        [weakSelf loadNumberButton:bu];
    }];
}


- (void)saveResPonseWithIndex:(ASTIndex )index
{
    
     //"examCode">考生准考证号</param>
     /// <param name="itemId">待保存试题id</param>
     /// <param name="itemType">试题类型</param>
     /// <param name="LastPartIndex">最后部分索引</param>
     /// <param name="LastSectionIndex">最后章节索引</param>
     /// <param name="LastItemIndex">最后题目索引</param>
     /// <param name="LastProgress">最后进度</param>
     /// <param name="itemResponse">答题结果</param>
     /// <param name="lastItemId
     
    
    if (index.textPart == -1) {
        index = _exerciseView.index ;
    }
    
    

    if (index.assessmentItemRef == 0) {
        return ;
    }
    
    
    TestPart * part  = _papaerModel.testPartArray[index.textPart -1] ;
    
    AssessmentSection * section  = part.assessmentSectionArray[index.assessmentSection -1] ;
    
    AssessmentItemRef * modelref = section.assessmentItemRefArray[index.assessmentItemRef -1] ;
    
    
    if (modelref.userChoice.length == 0 && modelref.userResDic == nil) {
        return ;
    }
    
    Candidates * canModel = [User shareInstance].candiateModel;
    
    NSString * s =  [[modelref.href componentsSeparatedByString:@"_"][1] stringByReplacingOccurrencesOfString:@".xml" withString:@""];
    
    __block  NSString * respos =  @"" ;
    
    if (modelref.userChoice.length) {
        
        if ([modelref.userChoice rangeOfString:@"RESPONSE"].length > 0) {
            respos = [modelref.userChoice stringByReplacingOccurrencesOfString:@" " withString:@""];
        }else
        {
            respos = [s stringByAppendingFormat:@"_RESPONSE=%@",modelref.userChoice] ;
        }
    }else if (modelref.userResDic)
    {
        [modelref.userResDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            NSLog(@"-----------%@--------%@",key,obj) ;
            respos = [respos stringByAppendingFormat:@"%@_RESPONSE_%d=%@&",s,[key intValue]%100 ,obj] ;
        }];
        
        
        if (respos.length) {
            respos = [respos substringToIndex:respos.length -1];
        }
    }
    
    respos = [respos stringByReplacingOccurrencesOfString:@" " withString:@""];
    index = [self debugIndexWith:index];
    
    if (index.assessmentItemRef < 1) {
        return ;
    }
    

    
    [NetWorking postWithUrl:SaveResponse andParameter:@{
                                                        @"itemId"       :   s,
                                                        @"itemType"     :   [User typeNumberWithType:modelref.type],
                                                        @"LastPartIndex":   @(index.textPart),
                                                        @"LastSectionIndex":@(index.assessmentSection),
                                                        @"LastItemIndex":   @(index.assessmentItemRef),
                                                        @"LastProgress" :   @"2",
                                                        @"itemResponse" :   respos,
                                                        @"examCode"     :   canModel.ExamCardNo,
                                                        @"lastItemId"   :   s
                                                        } andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
                                                            NSLog(@"保存成功--------------------------%@",respon) ;
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            
                                                        }];
     
     
    

}


- (void)loadNumberButton:(NumberButton *)bu
{
    [self saveResPonseWithIndex:(ASTIndex){-1,0,0}];
    ASTIndex    index = bu.index ;
    _testNoteView.itemBu = bu ;
    TestPart * part = _papaerModel.testPartArray[index.textPart -1] ;
    AssessmentSection * section = part.assessmentSectionArray[index.assessmentSection -1];
    AssessmentItemRef * ref = section.assessmentItemRefArray[index.assessmentItemRef -1] ;
    _exerciseView.index = index ;
    [_exerciseView loadAssMent:ref];
    
}

- (void)back
{
    [_manger stop];
    [super back];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)timeEnd
{
    if(_soundIndex.textPart == 1){
        TestPart * part = _papaerModel.testPartArray[0] ;
        if (part.assessmentSectionArray.count > _soundIndex.assessmentSection -1) {
            AssessmentSection * asseSection = part.assessmentSectionArray[_soundIndex.assessmentSection -1] ;
            
            [_numberView setSelectBuWithIndex:_soundIndex];
            
            int index = (int)_soundIndex.assessmentItemRef -1 ;
            
            if (asseSection.assessmentItemRefArray.count > index ) {
                [_manger playWithPath:[asseSection.assessmentItemRefArray[index] media].src];
                _soundIndex.assessmentItemRef ++ ;
            }
            
            if(index > 1)
            {
                if ([User shareInstance].againModel.isFirst) {
                    [User shareInstance].againModel.isFirst = NO;
                }else
                {
                AssessmentItemRef * ref = asseSection.assessmentItemRefArray[index -1] ;
                if (!isCanUseString(ref.userChoice) && !ref.userResDic) {
                   
                    [NetWorking postWithUrl:EndHearTest andParameter:@{
                                                                       @"examCode"      :[User shareInstance].candiateModel.ExamCardNo,
                                                                       @"itemId":@"",
                                                                       @"lastPartIndex":   @(0),
                                                                       @"lastSectionIndex":@(0),
                                                                       @"lastItemIndex" :@(index +1),
                                                                       @"LastProgress" :  @"3",
                                                                       @"isExample"   :   @"0"
                                                                       } andSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respon) {
                                                                           NSLog(@"结束听力成功") ;
                                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                           NSLog(@"%@",error) ;
                                                                       }];

                    
                    
                }
            }
            }
        }else if (part.assessmentSectionArray.count == _soundIndex.assessmentSection -1)
        {
            [_testNoteView endBuEvent:nil];
        }else if (part.assessmentSectionArray.count == _soundIndex.assessmentSection -2)
        {
            [_testNoteView endBuEvent:nil];
        }
        
    }else{

        [_testNoteView endBuEvent:nil];
    }

    }

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    TestPart * part = _papaerModel.testPartArray[0] ;
    
    AssessmentSection * section = nil ;
    if (_soundIndex.assessmentSection == 0) {
        section = part.assessmentSectionArray[0];
        _soundIndex.assessmentSection = 1 ;
        _soundIndex.assessmentItemRef = 1 ;
    }else if (part.assessmentSectionArray.count > _soundIndex.assessmentSection -1 && [part.assessmentSectionArray[_soundIndex.assessmentSection -1] assessmentItemRefArray].count+1 == _soundIndex.assessmentItemRef)
    {
        if (part.assessmentSectionArray.count > _soundIndex.assessmentSection) {
            section = part.assessmentSectionArray[_soundIndex.assessmentSection++];
            _soundIndex.assessmentItemRef = 1 ;
        }else
        {
            _soundIndex.assessmentSection++ ;
        }
    }
    
    if (section) {
        [_manger playWithPath:section.rubricMedia.src];
    }else
    {
        
        if (!_testNoteView.isClock) {
            [self timeEnd];
        }
    }
}

- (void)nextPart
{
    if ([User shareInstance].againModel) {
        [self subMitPaper];
        return ;
    }
    
    if (_soundIndex.textPart == 2) {
        TestPart * part = _papaerModel.testPartArray[1] ;
        AssessmentSection * sec = part.assessmentSectionArray.lastObject ;
        [self saveResPonseWithIndex:(ASTIndex){2,part.assessmentSectionArray.count,sec.assessmentItemRefArray.count}];
    }
    
    _soundIndex.textPart ++ ;
    _soundIndex.assessmentItemRef = 1 ;
    _soundIndex.assessmentSection = 1 ;
    _testNoteView.clockLabel.text = @"00:00" ;
    [_numberView setTestPart:(int)_soundIndex.textPart];
    
    [_numberView setSelectBuWithIndex:_soundIndex];
    
}


- (ASTIndex )debugIndexWith:(ASTIndex )index
{
    Candidates * canModel = [User shareInstance].candiateModel;
    int level = canModel.SubjectCode.intValue ;
    
    if (level == 1 && (index.textPart == 1 || index.textPart == 2) && index.assessmentSection == 1) {
        index.textPart -= 1 ;
        index.assessmentSection = 0 ;
        index.assessmentItemRef -= 2 ;
    }else if (level == 1 && index.textPart == 1 && index.assessmentSection == 2)
    {
        index.textPart = 0 ;
        index.assessmentSection = 0 ;
        index.assessmentItemRef -= 1 ;
    }else if (level == 1 && index.textPart == 1 && index.assessmentSection == 3)
    {
        index.textPart = 0 ;
        index.assessmentSection = 0 ;
    }else if (level == 1 && index.textPart == 1 && index.assessmentSection == 4)
    {
        index.textPart = 0 ;
        index.assessmentSection = 0 ;
        index.assessmentItemRef -= 1 ;
    }else if (level == 1 && index.textPart == 2 && index.assessmentSection > 1)
    {
        index.textPart = 1 ;
        index.assessmentSection -= 1 ;
    }else if ((level == 2 && index.textPart == 1 && index.assessmentSection == 1)|| (index.textPart == 2 && index.assessmentSection == 3 && level == 2)) {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
        index.assessmentItemRef -= 2 ;
    }else if(level == 2 && index.textPart == 1 && index.assessmentSection == 2)
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;

    }else if (level == 2 && index.textPart == 1 && (index.assessmentSection == 3 || index.assessmentSection == 4))
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
        index.assessmentItemRef -= 1 ;
    }else if  (level == 2 && index.textPart == 2 && (index.assessmentSection == 1 || index.assessmentSection == 2 || index.assessmentSection == 4))
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
    }else if ((level == 3 && index.textPart == 1 && index.assessmentSection == 1)|| (level == 3 && index.textPart == 2 &&(index.assessmentSection == 1 || index.assessmentSection == 2)))
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
    }else if (level == 3 && index.textPart == 1 && index.assessmentSection == 2)
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
        index.assessmentItemRef -= 2 ;
    }else if (level == 3 &&(index.textPart == 1 || index.textPart == 2) && (index.assessmentSection == 3 || index.assessmentSection == 4))
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
        index.assessmentItemRef -= 1 ;
    }else if (level == 3 &&  index.textPart == 3 )
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
        index.assessmentItemRef -= 1 ;

    }else if (level == 4 && (index.textPart == 1) && index.assessmentSection == 1) {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
        index.assessmentItemRef -= 2 ;
    }else if(level == 4 && (index.textPart == 1 || index.textPart == 2 )&& (index.assessmentSection == 2 || index.assessmentSection == 3)) {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
        index.assessmentItemRef -= 1 ;
    }else if(level == 4 &&  index.textPart == 2 && index.assessmentSection == 1) {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
    }else if(level == 4 &&  index.textPart == 3 ) {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
        index.assessmentItemRef -= 1 ;
    }else if (level == 5 && index.textPart == 3 && index.assessmentSection == 1)
    {
        index.textPart -= 1 ;
        index.assessmentSection  -= 1 ;
        index.assessmentItemRef -= 1 ;

    }else if (level == 5 )
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
    }else if (level == 6)
    {
        index.textPart -= 1 ;
        index.assessmentSection -= 1 ;
    }

    
    return index ;
}

@end
