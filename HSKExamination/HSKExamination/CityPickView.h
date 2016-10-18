//
//  CityPickView.h
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCenter.h"
@interface CityPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic ,copy) void(^block)(TestCenter * model) ;

- (void)show ;

- (void)hidden ;

- (void)loadData:(NSArray *)arr ;

@end
