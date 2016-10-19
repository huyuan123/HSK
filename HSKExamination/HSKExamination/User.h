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

@property (nonatomic ,strong) NSString *  paperPath ;

@property (nonatomic ,assign) int   level ;      //  等级


+ (User *)shareInstance ;


+ (NSMutableDictionary *)dictionaryWithLevel:(int)level ;

+ (void)setStatisticsWithType:(NSString *)type andIScorrect:(BOOL)b ;
@end
