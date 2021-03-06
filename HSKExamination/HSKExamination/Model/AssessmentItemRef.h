//
//  assessmentItemRef.h
//  HSKExamination
//
//  Created by printer on 9/12/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASTModel.h"
#import "Media.h"
@interface AssessmentItemRef : NSObject
@property (nonatomic ,strong) NSString  *  identifier ;
@property (nonatomic ,strong) NSString  *  href ;
@property (nonatomic ,strong) NSString  *  type ;
@property (nonatomic ,strong) NSString  *  subjective ;
@property (nonatomic ,strong) NSString  *  isExample ;
@property (nonatomic ,strong) NSString  *  prepareDuration ;
@property (nonatomic ,strong) NSString  *  responseDuration ;
@property (nonatomic ,strong) NSString  *  promptShowDuration ;

@property (nonatomic ,strong) NSString  *  userChoice ;
@property (nonatomic ,strong) NSMutableDictionary   *       userResDic ;
@property (nonatomic ,strong) Media     *   media  ;

@property (nonatomic ,strong) NSString      *       correctResponse ;
@property (nonatomic ,strong) NSArray       *       correctArr ;


@property (nonatomic ,assign) ASTIndex      astIndex ;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;

@end
