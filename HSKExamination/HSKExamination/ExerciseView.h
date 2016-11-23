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

@protocol ExerciseViewDelegate <NSObject>

- (void)next ;

@end


@interface ExerciseView : UIView<UIAlertViewDelegate>

@property (nonatomic ,weak) AudioManger * manger ;

@property (nonatomic ,strong) UIView     *  backView ;

@property (nonatomic ,strong) UILabel    *  countLabel ;

@property (nonatomic ,strong) UIImageView*  typeImageView ;

@property (nonatomic ,strong) id            assessection ;

@property (nonatomic ,assign) id     <ExerciseViewDelegate>       delegate ;


- (void)loadAssMent:(AssessmentItemRef *)model ;

@end
