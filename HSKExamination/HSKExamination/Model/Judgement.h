//
//  Judgement.h
//  HSKExamination
//
//  Created by hiddy on 16/9/25.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
#import "Media.h"
#import "Img.h"
@interface Judgement : XMLBaseModel  //  判断题
@property (nonatomic ,strong) NSString      *       identifier ;
@property (nonatomic ,strong) NSString      *       title ;

@property (nonatomic ,strong) NSMutableArray       *       simpleChoiceArray ;
@property (nonatomic ,strong) Media         *       media ;
@property (nonatomic ,strong) Img           *       img ;
@property (nonatomic ,strong) NSString      *       correctResponse ;
@end
