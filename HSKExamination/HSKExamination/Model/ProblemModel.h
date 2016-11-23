//
//  ProblemModel.h
//  HSKExamination
//
//  Created by printer on 9/27/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
#import "SimpleChoice.h"
#import "AssessmentSection.h"
extern NSString         *   _currentElement ;
extern SimpleChoice     *   _model ;
extern int                  _index ;
extern BOOL   isCorrectResponse ;
extern ASTIndex   astIndex ;

extern TestPart  *  testPartModel ;
extern AssessmentSection  *  assessmentSection         ;
extern AssessmentItemRef  *  assessmentItem            ;

@interface ProblemModel : XMLBaseModel
@property (nonatomic ,strong) NSString      *       identifier ;
@property (nonatomic ,strong) NSString      *       title ;


+ (id)createChildWithLevel:(int)level ;

@end
