//
//  NSObject+Runtime.h
//  Runtime
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Runtime)


/* ------------------------------------ */
// 获取当前类所有的子类
+ (NSArray *)runtimeSubClasses;
- (NSArray *)runtimeSubClasses;

// 获取当前类所有的父类继承关系
+ (NSString *)runtimeParentClassHierarchy;
- (NSString *)runtimeParentClassHierarchy;
/* ------------------------------------ */


/* ------------------------------------ */
// 获取当前类类方法
+ (NSArray *)runtimeClassMethods;
- (NSArray *)runtimeClassMethods;

// 获取当前类实例方法
+ (NSArray *)runtimeInstanceMethods;
- (NSArray *)runtimeInstanceMethods;
/* ------------------------------------ */


/* ------------------------------------ */
// 获取当前类实例变量大小
+ (size_t)runtimeInstanceSize;
- (size_t)runtimeInstanceSize;

// 获取当前类的所有属性
+ (NSArray *)runtimeProperties;
- (NSArray *)runtimeProperties;
/* ------------------------------------ */


// 获取当前类继承的所有协议
+ (NSArray *)runtimeProtocols;
- (NSArray *)runtimeProtocols;

@end
