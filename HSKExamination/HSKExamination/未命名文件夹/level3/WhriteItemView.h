//
//  WhriteItemView.h
//  HSKExamination
//
//  Created by hiddy on 16/10/23.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleChoice.h"
@interface WhriteItemView : UIView

@property (nonatomic ,strong) SimpleChoice *  text ;

@property (nonatomic ,copy)void (^block)() ;

@end
