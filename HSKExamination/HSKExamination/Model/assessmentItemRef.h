//
//  assessmentItemRef.h
//  HSKExamination
//
//  Created by printer on 9/12/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface assessmentItemRef : NSObject
@property (nonatomic ,strong) NSString  *  identifier ;
@property (nonatomic ,strong) NSString  *  href ;
@property (nonatomic ,strong) NSString  *  type ;
@property (nonatomic ,strong) NSString  *  subjective ;
@property (nonatomic ,strong) NSString  *  isExample ;
@property (nonatomic ,strong) NSString  *  prepareDuration ;
@property (nonatomic ,strong) NSString  *  responseDuration ;
@property (nonatomic ,strong) NSString  *  promptShowDuration ;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;

@end
