//
//  ASTModel.h
//  HSKExamination
//
//  Created by printer on 9/8/16.
//  Copyright © 2016 printer. All rights reserved.
//
//          试卷类
#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
#import "testPart.h"

typedef struct {
    NSUInteger  textPart ;
    NSUInteger  assessmentSection ;
    NSUInteger assessmentItemRef ;
}ASTIndex ;

@interface ASTModel : XMLBaseModel
@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
@property (nonatomic ,strong) NSString * title ;  // title
@property (nonatomic ,strong) NSMutableArray * testPartArray ;  // 试卷的几个块

//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//@property (nonatomic ,strong) NSString * identifier ;  // 试卷ID
//

@end
