//
//  User.h
//  HSKExamination
//
//  Created by printer on 9/20/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic ,strong) NSString *  testDownLoadUrl ;

+ (User *)shareInstance ;


@end
