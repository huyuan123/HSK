//
//  ProblemModel.h
//  HSKExamination
//
//  Created by printer on 9/27/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBaseModel.h"
@interface ProblemModel : XMLBaseModel
@property (nonatomic ,strong) NSString      *       identifier ;
@property (nonatomic ,strong) NSString      *       title ;

@end
