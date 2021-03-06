//
//  SimpleChoice.h
//  HSKExamination
//
//  Created by hiddy on 16/10/2.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Img.h"
@interface SimpleChoice : BaseModel
@property (nonatomic , strong) NSString         *       identifier ;
@property (nonatomic , strong) NSString         *       textString ;
@property (nonatomic , strong) NSString         *       pinYInString ;
@property (nonatomic , strong) Img              *       img ;

@property (nonatomic , strong) NSMutableArray   *       array ;

@end
