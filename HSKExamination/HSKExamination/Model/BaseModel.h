//
//  BaseModel.h
//  HSKExamination
//
//  Created by hiddy on 16/10/2.
//  Copyright © 2016年 printer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
