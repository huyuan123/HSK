//
//  ReadingComprehensionModel.h
//  HSKExamination
//
//  Created by printer on 9/28/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemModel.h"
#import "Media.h"
#import "Img.h"
@interface ReadingComprehensionModel : NSObject

@property (nonatomic ,strong) NSMutableArray        *       correctResponseArray ;

@property (nonatomic ,strong) Media                 *       media ;

@property (nonatomic ,strong) NSMutableArray        *       imgArray ;

@end
