//
//  NSObject+WeakRelated.h
//  ScrollViewShowImage
//
//  Created by YouXianMing on 14-9-24.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WeakRelated)

// 与对象弱相关联系
- (void)setRelatedObject:(id)object;

// 取出建立关系的对象
- (id)relatedObject;

@end
