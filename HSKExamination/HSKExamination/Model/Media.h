//
//  Media.h
//  HSKExamination
//
//  Created by printer on 9/26/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    testPart,
    judgeMent
} SrcType ;

@interface Media : NSObject
@property (nonatomic ,strong) NSString * src  ;  // 路径
@property (nonatomic ,strong) NSString * duration  ;  // 路径
@property (nonatomic ,strong) NSString * repeatTimes  ;  // 路径
@property (nonatomic ,strong) NSString * repeatInterval  ;  // 路径
@property (nonatomic ,strong) NSString * mimeType  ;  // 路径
@property (nonatomic ,strong) NSString * content  ;  // 路径
@property (nonatomic ,assign) SrcType   srcType  ;  // 路径



- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;

@end
