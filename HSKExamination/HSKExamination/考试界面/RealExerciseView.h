//
//  RealExerciseView.h
//  HSKExamination
//
//  Created by printer on 2016/11/3.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealExerciseView : UIView<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic ,strong) UIView     *  backView ;

@property (nonatomic ,assign) ASTIndex      index ;

@property (nonatomic ,strong) id            assessection ;

@property (nonatomic ,copy) void(^block)(BOOL b) ;

- (void)loadAssMent:(AssessmentItemRef *)model ;

@end
