//
//  ExaminationNumberView.h
//  HSKExamination
//
//  Created by printer on 2016/10/28.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTModel.h"
#import "NumberButton.h"
@interface ExaminationNumberView : UIView

@property (nonatomic ,copy)void(^clickBlock)(NumberButton * bu) ;

- (void)setSelectBuWithIndex:(ASTIndex )indexModel ;

- (void)nextWithIndex:(ASTIndex )indexModel ;

- (void)initData ;

- (void)setTestPart:(int)part ;
@end
