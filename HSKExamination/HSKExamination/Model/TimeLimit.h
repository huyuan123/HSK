//
//  TimeLimits.h
//  HSKExamination
//
//  Created by hiddy on 16/11/1.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface TimeLimit : BaseModel
@property (nonatomic ,strong) NSString      *       maxTime ;
@property (nonatomic ,strong) NSString      *       checkTime ;
@end
