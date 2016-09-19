//
//  NSString+File.h
//  Category
//
//  Created by YouXianMing on 14-8-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    Documents ,
    tmp,
    Caches,
    Preferences
}pathType ;

@interface NSString (File)

// 沙盒路径
- (NSString *)path;
/*
 /Documents
 /Library/Caches
 /Library/Preferences
 /tmp
 */
- (NSString *)pathWithType:(pathType)type ;
// bundle文件
- (NSString *)bundleFile;

// bundle图片
- (UIImage *)bundleImage;

// 检测文件或者文件夹是否存在
- (BOOL)exist;

// 创建文件夹
- (BOOL)createFolder;

// 是否是文件夹
- (BOOL)isDirectory;

// 复制到这个路径
- (BOOL)copyTo:(NSString *)path;

// 移动到这个路径
- (BOOL)moveTo:(NSString *)path;

// 删除文件
- (BOOL)remove;

// 遍历出文件夹中的文件
- (NSArray *)enumeratorFolder;

// 遍历出文件夹并在block中查看
- (void)enumeratorFolderEach:(void (^)(NSString *path))block;

// 文件信息
- (NSDictionary *)fileInfo;

// 文件大小
- (int)fileSize;

@end
