//
//  AgainExamModel.h
//  HSKExamination
//
//  Created by printer on 2016/11/15.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface AgainExamModel : BaseModel
@property (nonatomic ,strong)   NSString        *       CurrentItemID ;
@property (nonatomic ,strong)   NSString        *       CurrentItemIndex ;
@property (nonatomic ,strong)   NSString        *       CurrentPartIndex ;
@property (nonatomic ,strong)   NSString        *       CurrentPartRemainTime ;
@property (nonatomic ,strong)   NSString        *       CurrentProgress ;
@property (nonatomic ,strong)   NSString        *       CurrentSectionIndex ;
@property (nonatomic ,assign)   BOOL                    isFirst ;

@end
