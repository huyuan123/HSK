//
//  ExerciseView.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssessmentItemRef.h"
#import "AudioManger.h"

@interface ExerciseView : UIView

@property (nonatomic ,weak) AudioManger * manger ;

@property (nonatomic ,strong) UIView     *  backView ;

@property (nonatomic ,strong) UILabel    *  countLabel ;

@property (nonatomic ,strong) UIImageView*  typeImageView ;

@property (nonatomic ,strong) id            assessection ;

- (void)loadAssMent:(AssessmentItemRef *)model ;

@end
