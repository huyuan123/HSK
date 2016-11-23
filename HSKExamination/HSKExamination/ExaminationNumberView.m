//
//  ExaminationNumberView.m
//  HSKExamination
//
//  Created by printer on 2016/10/28.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "ExaminationNumberView.h"
#import "NumberButton.h"
@implementation ExaminationNumberView
{
    UIView      *       _progressView ;
    UIScrollView*       _backView ;
    NSArray     *       _dataArray ;
    int                 _testPart ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _testPart = 1 ;
        self.cornerRadius = 20 ;
        self.backgroundColor = RGBCOLOR(189, 225, 47) ;
        [self createSoundProGress];
    }
    
    return self ;
}

- (void)createSoundProGress
{
    UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    [bu setImage:[UIImage imageNamed:@"喇叭图标"] forState:BuNormal];
    [self addSubview:bu];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(60, 20, 170, 10)];
    [self addSubview:view];
    view.backgroundColor = RGBCOLOR(218, 218, 218) ;
    view.cornerRadius = 5 ;
    
    _progressView = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:_progressView];
    _progressView.backgroundColor = RGBCOLOR(153, 153, 153) ;
    _progressView.width = 50 ;
    
    [self createButtonsView];
    
}

- (void)createButtonsView
{
    NSArray * array = nil ;
    
    int level = [User shareInstance].candiateModel.SubjectCode.intValue ;
  
    if (level > 2) {
        array =     @[@"听力",@"阅读",@"书写"] ;
    }else
    {
        array = @[@"听力",@"阅读"];
    }
    for (int i = 0; i < array.count; i++) {
        UIButton * bu = [[UIButton alloc] initWithFrame:CGRectMake(20 + 70*i, 50, 65, 40)];
        [self addSubview:bu];
        bu.backgroundColor = RGBCOLOR(153, 153, 153) ;
        [bu setTitle:array[i] forState:BuNormal];
        bu.titleLabel.font = Font14 ;
        [bu addTarget:self action:@selector(changePart:) forControlEvents:BuTouchUpInside];
        bu.tag = 10 + i ;
        bu.cornerRadius = 10 ;
        bu.enabled = NO ;
    }
    
}

- (void)changePart:(UIButton *)bu
{
    for (int i = 0; i < 3; i++) {
        UIButton * bu = [self viewWithTag:10 + i];
        bu.backgroundColor = RGBCOLOR(153, 153, 153) ;
        [bu setTitleColor:[UIColor whiteColor] forState:BuNormal];
    }
    
    bu.backgroundColor = [UIColor whiteColor];
    [bu setTitleColor:self.backgroundColor forState:BuNormal];
    _testPart = (int)bu.tag - 9 ;
    [self createButtonsWith:(int)bu.tag -9];
}

- (void)initData
{
    Candidates * canModel = [User shareInstance].candiateModel ;
    int level = canModel.SubjectCode.intValue ;
    
    switch (level) {
        case 1:
        {

            //  听力的题号
            NSArray * array1 = @[@"例1",@"例2",@"1",@"2",@"3",@"4",@"5"] ;
            NSArray * array2 = @[@"例1",@"6",@"7",@"8",@"9",@"10"] ;
            NSArray * array3 = @[@"11-15"] ;
            NSArray * array4 = @[@"例1",@"16",@"17",@"18",@"19",@"20",] ;

            //  阅读的题号

            NSArray * array5 = @[@"例1",@"例2",@"21",@"22",@"23",@"24",@"25"] ;
            NSArray * array6 = @[@"26-30"] ;
            NSArray * array7 = @[@"31-35"] ;
            NSArray * array8 = @[@"36-40"] ;
            _dataArray = @[@[array1,array2,array3,array4],@[array5,array6,array7,array8]] ;
            
        }
            break;
        case 2:
        {
            //  听力的题号
            NSArray * array1 = @[@"例1",@"例2",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"] ;
            NSArray * array2 = @[@"11-15",@"16-20"] ;
            NSArray * array3 = @[@"例1",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"] ;
            NSArray * array4 = @[@"例1",@"31",@"32",@"33",@"34",@"35",] ;
            
            //  阅读的题号
            
            NSArray * array5 = @[@"36-40"] ;
            NSArray * array6 = @[@"41-45"] ;
            NSArray * array7 = @[@"例1",@"例2",@"46",@"47",@"48",@"49",@"50"] ;
            NSArray * array8 = @[@"51-55",@"56-60"] ;
            _dataArray = @[@[array1,array2,array3,array4],@[array5,array6,array7,array8]] ;

        }
            break;
        case 3:
        {
            //  听力的题号
            NSArray * array1 = @[@"1-5",@"6-10"] ;
            NSArray * array2 = @[@"例1",@"例2",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"] ;
            NSArray * array3 = @[@"例1",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"] ;
            NSArray * array4 = @[@"例1",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",] ;
            
            //  阅读的题号
            
            NSArray * array5 = @[@"41-45",@"46-50"] ;
            NSArray * array6 = @[@"51-55",@"56-60"] ;
            NSArray * array7 = @[@"例1",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70"] ;

            //  书写题的题号
            NSArray * array8 = @[@"例1",@"71",@"72",@"73",@"74",@"75"] ;
            NSArray * array9 = @[@"例1",@"76",@"77",@"78",@"79",@"80"] ;
            
            _dataArray = @[@[array1,array2,array3,array4],@[array5,array6,array7],@[array8,array9]] ;
            
        }
            break;
        case 4:
        {
            //  听力的题号
            NSArray * array1 = @[@"例1",@"例2",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"] ;
            NSArray * array2 = @[@"例1",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
                                 @"20",@"21",@"22",@"23",@"24",@"25"] ;
            NSArray * array3 = @[@"例1",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",
                                 @"36-37",@"38-39",@"40-41",@"42-43",@"44-45"] ;
            
            
            //  阅读的题号
            
            NSArray * array5 = @[@"46-50",@"51-55"] ;
            NSArray * array6 = @[@"例1",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",] ;
            NSArray * array7 = @[@"例1",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75"
                                 ,@"76",@"77",@"78",@"79",@"80-81",@"82-83",@"84-85"] ;
            
            //  书写题的题号
            NSArray * array8 = @[@"例1",@"86",@"87",@"88",@"89",@"90",@"91",@"92",@"93",@"94",@"95"] ;
            NSArray * array9 = @[@"例1",@"96",@"97",@"98",@"99",@"100"] ;
            
            _dataArray = @[@[array1,array2,array3],@[array5,array6,array7],@[array8,array9]] ;

        }
            break;
        case 5:
        {
            //  听力的题号

            
            NSArray * array1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"] ;

            NSArray * array2 = @[@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",
                                 @"31-32",@"33-34",@"35-36",@"37-38",@"39-42",@"43-45"];
            

            // 阅读题的题号
            NSArray *  array3 = @[@"46-48",@"49-52",@"53-56",@"57-60"] ;
            
            NSArray * array4 = @[@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70"] ;
            
            NSArray * arrray5 = @[@"71-73",@"74-77",@"78-82",@"83-86",@"87-90"] ;

            
            //  写作部分题号
            NSArray * array6 = @[@"例1",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98"] ;
            NSArray * array7 = @[@"99",@"100"] ;
            
            _dataArray = @[@[array1,array2],@[array3,array4,arrray5],@[array6,array7]] ;
        }
            break;
        case 6:
        {
            //  听力题号
            NSArray * array1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                 @"11",@"12",@"13",@"14",@"15"] ;
            NSArray * array2 = @[@"16-20",@"21-25",@"26-30"] ;
            
            NSArray * array3 = @[@"31-33",@"34-37",@"38-40",@"41-43",@"44-47",@"48-50"] ;
            
            // 阅读题号
            
            NSArray * array4 = @[@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60"] ;

            NSArray * array5 = @[@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70"] ;
            
            NSArray * array6 = @[@"71-75",@"76-80"] ;
            
            NSArray * array7 = @[@"81-84",@"85-88",@"89-92",@"93-96",@"97-100"] ;

            // 写作题号
            
            NSArray * array8 = @[@"101"] ;
            
            _dataArray = @[@[array1,array2,array3],@[array4,array5,array6,array7],@[array8]] ;

        }
            break;
            
        default:
            break;
    }
    
    [self changePart:[self viewWithTag:10]];

}


- (void)createButtonsWith:(int)index //  1  为听力    2  为阅读   3  为书写
{
    
        [_backView removeFromSuperview];
        _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 80, self.width -10, self.height - 85)];
        [self addSubview:_backView];
        _backView.backgroundColor = [UIColor whiteColor] ;
        _backView.cornerRadius = 20 ;

        NSArray * array = _dataArray[index -1] ;
        CGFloat y = 0 ;
        CGFloat width = _backView.width/3 - 10 ;
        for (int j = 0; j < array.count; j++) {
            NSArray * arr = array[j] ;
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30+y, _backView.width - 20, 40)];
            [_backView addSubview:label];
            label.font = Font18 ;
            label.text = [NSString stringWithFormat:@"第%d部分",j+1];
            if(j == 0)  label.y -= 30 ;
            y += j ==0?45:70 ;
            
            
            for (int k = 0; k < arr.count; k ++) {
                
                y += (k%3==0 && k!= 0)? 35 : 0;
                NumberButton * bu = [[NumberButton alloc] initWithFrame:CGRectMake(10 + k%3*(width + 5), y, width, 25)];
                [_backView addSubview:bu];
                [bu setIsSelect:NO];
                [bu setTitle:arr[k] forState:BuNormal];
                
                bu.index = (ASTIndex){_testPart,j+1,k+1} ;
                
                [bu addTarget:self action:@selector(buClick:) forControlEvents:BuTouchUpInside];
            }
        }
    
    _backView.contentSize = CGSizeMake(10 , y + 60) ;
}


- (void)buClick:(NumberButton *)bu
{
    NSArray * array = [_backView subviews];
    for (NumberButton * button in array) {
        if ([button isKindOfClass:[NumberButton class]]) {
            [button setIsSelect:NO];
        }
    }
    
    [bu setIsSelect:YES];
    
    bu.tag = 0 ;
    if (_clickBlock) {
        _clickBlock(bu) ;
    }
}


- (void)setSelectBuWithIndex:(ASTIndex )indexModel
{
//    NSLog(@"----testPart = %d-----sec=%d------ref=%d",indexModel.textPart,indexModel.assessmentSection,indexModel.assessmentItemRef) ;
    NumberButton * bu = nil ;
    NSArray * array = [_backView subviews];
    for (NumberButton * button in array) {
        if ([button isKindOfClass:[NumberButton class]]) {
            [button setIsSelect:NO];
            if (button.index.assessmentSection == indexModel.assessmentSection && button.index.assessmentItemRef == indexModel.assessmentItemRef) {
                bu = button ;
            }
        }
    }
    
    [bu setIsSelect:YES];

    if (_clickBlock && bu) {
        bu.tag = 100 ;
        _clickBlock(bu) ;
    }

}

- (void)nextWithIndex:(ASTIndex )indexModel
{
    NumberButton * bu = nil ;
    NSArray * array = [_backView subviews];
    for (NumberButton * button in array) {
        if ([button isKindOfClass:[NumberButton class]]) {
            [button setIsSelect:NO];
            if (button.index.assessmentSection == indexModel.assessmentSection && button.index.assessmentItemRef == indexModel.assessmentItemRef) {
                bu = button ;
            }
        }
    }
    
    [bu setIsSelect:YES];
    
    if (_clickBlock && bu) {
        bu.tag = 0 ;
        _clickBlock(bu) ;
    }
}


- (void)setTestPart:(int)part
{
    [self changePart:[self viewWithTag:part + 9]];

}


@end
