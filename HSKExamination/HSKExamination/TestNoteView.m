//
//  TestNoteView.m
//  HSKExamination
//
//  Created by hiddy on 16/11/2.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "TestNoteView.h"

@implementation TestNoteView
{
    UILabel     *       _timeLabel ;
    UILabel     *       _noteLabel ; // 题目说明label
    UIImageView *       _iconView ;  //
    UILabel     *       _titleLabel ;
    UILabel     *       _clockLabel ;
    NSTimer     *       _timer ;
    
//    UIButton    *       _endButton ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cornerRadius = 20 ;
        self.backgroundColor = RGBCOLOR(188, 225, 82) ;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 22, 35, 35)];
        [self addSubview:_iconView];
        _iconView.contentMode = UIViewContentModeScaleAspectFit ;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 22, 60, 30)];
        [self addSubview:_titleLabel];

        _titleLabel.font = [UIFont boldSystemFontOfSize:26] ;
        _titleLabel.textColor = [UIColor whiteColor];

        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 22, 150, 30)];
        [self addSubview:_timeLabel];
        _timeLabel.font = Font14 ;
        _timeLabel.textColor = RGBCOLOR(96, 96, 107) ;
        
        _clockLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 22, 50, 30)];
        _clockLabel.textColor = [UIColor whiteColor];
        [self addSubview:_clockLabel];
        
        _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 22, 400, 30)];
        _noteLabel.textColor = _timeLabel.textColor ;
        [self addSubview:_noteLabel];
        
        _iconView.image = [UIImage imageNamed:@"耳机图标-white"];
        _titleLabel.text = @"听力" ;

        
        _endButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 100, 20, 90, frame.size.height -40)];
        [self addSubview:_endButton];
        _endButton.titleLabel.font = Font14 ;
        [_endButton setTitle:@"结束听力" forState:BuNormal];
        _endButton.cornerRadius = _endButton.height/2 ;
        _endButton.layer.borderColor = [UIColor blackColor].CGColor ;
        _endButton.layer.borderWidth = 1 ;
        [_endButton addTarget:self action:@selector(endBuEvent:) forControlEvents:BuTouchUpInside];
        
        [self startTime];
    }
    
    return self ;
}

- (void)startTime
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeEvent:) userInfo:nil repeats:YES];

}

- (void)endBuEvent:(UIButton *)bu
{
    int level = [User shareInstance].candiateModel.SubjectCode.intValue;

    if(bu == nil)
    {
        bu = _endButton ;
    }
    if ([bu.titleLabel.text isEqualToString:@"结束听力"]) {
        [bu setTitle:@"结束听力回顾" forState:BuNormal];
        if(_hearBackBlock)
        {
            _hearBackBlock(1) ;
        }
    }else if ([bu.titleLabel.text isEqualToString:@"结束听力回顾"])
    {
        if(level < 3)
        {
            [bu setTitle:@"提交试卷" forState:BuNormal];
    
        }else
        {
            [bu setTitle:@"结束阅读" forState:BuNormal];
        }
        
        if(_hearBackBlock)
        {
            _hearBackBlock(2) ;
        }
    }else if  ([bu.titleLabel.text isEqualToString:@"结束阅读"])
    {
      
            [bu setTitle:@"提交试卷" forState:BuNormal];
        if(_hearBackBlock)
        {
            _hearBackBlock(2) ;
        }

    }else if ([bu.titleLabel.text isEqualToString:@"提交试卷"])
    {
        if(_hearBackBlock)
        {
            _hearBackBlock(10) ;
        }
    }
}

- (void)timeEvent:(NSTimer *)timer
{
    NSString * timeString = _clockLabel.text ;
    if(![timeString isEqualToString:@"00:00"] && isCanUseString(timeString))
    {
        NSArray * arr = [timeString componentsSeparatedByString:@":"];
        int sec = [arr[0] intValue]*60 + [arr[1] intValue] ;
        sec -- ;
        [self setClockStringWithSec:sec];
    }else if ([timeString isEqualToString:@"00:00"] && _nextBlock)
    {
        _nextBlock() ;
    }
}


- (void)setClockStringWithSec:(int)sec
{
    int min = sec/60 ;
    int secs = sec%60 ;
    NSString * minString = [NSString stringWithFormat:@"%d",min];
    NSString * secsString = [NSString stringWithFormat:@"%d",secs];
    if (minString.length == 1) {
        minString = [@"0" stringByAppendingString:minString];
    }
    
    if (secsString.length == 1) {
        secsString = [@"0" stringByAppendingString:secsString];
    }
    
    _clockLabel.text = [NSString stringWithFormat:@"%@:%@",minString,secsString];

}

- (void)setItemBu:(NumberButton *)itemBu
{

    _index = itemBu.index ;

    TestPart * part = _paperModel.testPartArray[itemBu.index.textPart -1] ;

    AssessmentSection * section = part.assessmentSectionArray[itemBu.index.assessmentSection -1] ;

    if (itemBu.index.textPart == 1) {
        _iconView.image = [UIImage imageNamed:@"耳机图标-white"];
        _titleLabel.text = @"听力" ;
        AssessmentItemRef * ref = section.assessmentItemRefArray[itemBu.index.assessmentItemRef -1];

        if (itemBu.tag == 100) {
            int time = ref.media.duration.intValue + ref.responseDuration.intValue ;
            [self setClockStringWithSec:time];
        }
        
        _timeLabel.text = [NSString stringWithFormat:@"第%@题 剩余时间",itemBu.titleLabel.text];
        _noteLabel.text = section.rubricBlock ;
    }else if (_index.textPart == 2)
    {
        _iconView.image = [UIImage imageNamed:@"阅读图标-white"];
        _titleLabel.text = @"阅读" ;
        
        if([_clockLabel.text isEqualToString:@"00:00"] || !isCanUseString(_clockLabel.text))
        {
            [self setClockStringWithSec:part.timeLimit.maxTime.intValue];
        }
        
        _timeLabel.text = [NSString stringWithFormat:@"阅读部分 剩余时间"];
        _noteLabel.text = section.rubricBlock ;
    }else if (_index.textPart == 3)
    {
        _iconView.image = [UIImage imageNamed:@"写作图标-white"];
        _titleLabel.text = @"写作" ;
        if(![self isClock])
        {
            [self setClockStringWithSec:part.timeLimit.maxTime.intValue];
        }
        
        _timeLabel.text = [NSString stringWithFormat:@"第%@题 剩余时间",itemBu.titleLabel.text];
        _noteLabel.text = section.rubricBlock ;

    }
    

}

- (void)hearBackWithTime:(int)time
{
    _timeLabel.text = [NSString stringWithFormat:@"听力回顾"];
    [self setClockStringWithSec:time];
    _noteLabel.text = @"" ;
    
}


- (BOOL)isClock
{
    NSString * s = _clockLabel.text ;
    return isCanUseString(s) && ![s isEqualToString:@"00:00"] ;
}


@end
