//
//  SelectView.h
//  HSKExamination
//
//  Created by printer on 9/29/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleChoice.h"
@interface SelectView : UIView

@property (nonatomic ,strong) NSString      *       userRes ;

@property (nonatomic ,copy) void(^clickBlock)(NSString * num,NSString * select) ;

- (void)loadData:(NSArray *)arr andTitle:(NSString *)title;

- (void)loadsimpleChoice:(SimpleChoice *)model ;

- (void)hiddenNumber ;
@end
