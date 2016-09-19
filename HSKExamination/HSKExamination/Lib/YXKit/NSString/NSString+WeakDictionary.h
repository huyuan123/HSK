//
//  NSString+WeakDictionary.h
//  YouXianMing
//
//  Created by YouXianMing on 14-9-20.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WeakDictionary)

// 直接根据字符串恢复出这存储的对象
- (id)recoverFromWeakDictionary;

@end
