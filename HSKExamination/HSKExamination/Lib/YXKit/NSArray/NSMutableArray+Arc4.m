//
//  NSMutableArray+Arc4.m
//  HSKExamination
//
//  Created by printer on 2016/10/20.
//  Copyright © 2016年 printer. All rights reserved.
//

#import "NSMutableArray+Arc4.h"

@implementation NSMutableArray (Arc4)
- (void)arc4Sort
{
    for (int i = 0; i < self.count; i++) {
        int m = (arc4random() % (self.count - i)) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:m];
    }

}
@end
