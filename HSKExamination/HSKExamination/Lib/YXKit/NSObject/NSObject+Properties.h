//
//  NSObject+Properties.h
//
//  Created by YouXianMing on 14-9-4.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Properties)

@property (nonatomic, strong) NSDictionary *mapDictionary;

- (void)setDataDictionary:(NSDictionary*)dataDictionary;
- (NSDictionary *)dataDictionary;

@end


