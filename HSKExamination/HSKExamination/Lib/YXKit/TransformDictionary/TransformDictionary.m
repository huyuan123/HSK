//
//  TransformDictionary.m
//  Dic
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "TransformDictionary.h"

@implementation TransformDictionary

+ (void)withDictionary:(NSDictionary *)dictionary fileName:(NSString *)name
{
    NSDictionary *dic         = dictionary;
    NSString *shortName       = name;
    NSString *fullHeadName    = [name stringByAppendingString:@".h"];
    NSString *fullContentName = [name stringByAppendingString:@".m"];
    
    // .h 文件头部信息
    __block NSString *headFileString = \
    [NSString stringWithFormat:@"//\n//  %@\n//\n//  Copyright (c) 2014年 Y.X. All rights reserved.\n//\n\n#import <Foundation/Foundation.h>\n\n@interface %@ : NSObject\n\n\n", fullHeadName, shortName];
    
    // .h 文件中间信息
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSString class]]) {
            if ([dic[key] isKindOfClass:[NSString class]]) {
                headFileString = [headFileString stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSString       *%@;\n", key]];
            } else if ([dic[key] isKindOfClass:[NSNumber class]]) {
                headFileString = [headFileString stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSNumber       *%@;\n", key]];
            } else if ([dic[key] isKindOfClass:[NSDictionary class]]) {
                headFileString = [headFileString stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary   *%@;\n", key]];
            } else if ([dic[key] isKindOfClass:[NSArray class]]) {
                headFileString = [headFileString stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSArray        *%@;\n", key]];
            } else {
                NSLog(@"%@   %@",[dic[key] class], key);
                headFileString = [headFileString stringByAppendingString:[NSString stringWithFormat:@"//@property (nonatomic, strong) %@     *%@;\n", [dic[key] class], key]];
            }
        }
    }];
    
    // - (void)setValue:(id)value forUndefinedKey:(NSString *)key
    headFileString = [headFileString stringByAppendingString:@"\n\n- (void)setValue:(id)value forUndefinedKey:(NSString *)key;\n"];
    
    // - (instancetype)initWithDictionary:(NSDictionary *)dictionary
    headFileString = [headFileString stringByAppendingString:@"- (instancetype)initWithDictionary:(NSDictionary *)dictionary;\n"];
    
    
    // .h 文件尾部信息
    headFileString = [headFileString stringByAppendingString:@"\n\n@end\n\n"];
    
    // .h 文件路径
    NSString *headFileStringPath = \
    [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@", fullHeadName]];
    
    NSLog(@"%@", headFileString);
    
    // 写文件
    [headFileString writeToFile:headFileStringPath
                     atomically:YES
                       encoding:NSUTF8StringEncoding
                          error:nil];
    
    
    // ================================================================================= //
    
    
    // .m 文件
    NSString *contentFileString = \
    [NSString stringWithFormat:@"//\n//  %@\n//\n//  Copyright (c) 2014年 Y.X. All rights reserved.\n//\n\n#import \"%@\"\n\n@implementation %@\n\n", fullContentName, fullHeadName, shortName];
    
    
    // .m 文件中间部分
    // - (void)setValue:(id)value forUndefinedKey:(NSString *)key
    contentFileString = [contentFileString stringByAppendingString:@"- (void)setValue:(id)value forUndefinedKey:(NSString *)key\n{\n//    if([key isEqualToString:@\"id\"]) {\n//        self.productID = value;\n//    }\n}\n"];
    
    // - (void)setValue:(id)value forKey:(NSString *)key
    contentFileString = [contentFileString stringByAppendingString:@"\n- (void)setValue:(id)value forKey:(NSString *)key\n{\n    if ([value isKindOfClass:[NSNull class]]) {\n        return;\n    }\n\n    [super setValue:value forKey:key];\n}"];
    
    // - (instancetype)initWithDictionary:(NSDictionary *)dictionary
    contentFileString = [contentFileString stringByAppendingString:@"\n- (instancetype)initWithDictionary:(NSDictionary *)dictionary\n{\n    self = [super init];\n    if (self)\n    {\n        if ([dictionary isKindOfClass:[NSDictionary class]])\n        {\n            [self setValuesForKeysWithDictionary:dictionary];\n        }\n    }\n\n    return self;\n}\n"];
    
    // .m 文件尾部信息
    contentFileString = [contentFileString stringByAppendingString:@"\n\n@end"];
    
    // .m 文件路径
    NSString *contentFileStringPath = \
    [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", fullContentName]];

    
    [contentFileString writeToFile:contentFileStringPath
                        atomically:YES
                          encoding:NSUTF8StringEncoding
                             error:nil];
    
    // 提示信息
    NSLog(@"生成的文件在以下路径中 \n%@", [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents"]]);

}

@end
