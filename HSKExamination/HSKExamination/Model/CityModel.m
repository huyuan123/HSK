//
//  CityModel.m
//  HSKExamination
//
//  Created by hiddy on 16/10/16.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "CityModel.h"
#import "TestCenter.h"
@implementation CityModel
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:_testCenters.count];
        for (NSDictionary * dic in _testCenters) {
            [arr addObject:[[TestCenter alloc] initWithDictionary:dic]] ;
        }
        
        _testCenters = arr ;
    }
    
    return self ;
}
@end
