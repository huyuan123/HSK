//
//  LevelPickView.h
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCenter.h"
@interface LevelPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,copy) void(^block)(NSString * model) ;

- (void)show ;

- (void)hidden ;

- (void)loadData:(NSArray *)arr ;

@end
