//
//  NSString+File.m
//  Category
//
//  Created by YouXianMing on 14-8-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

- (NSString *)path
{
    return [NSHomeDirectory() stringByAppendingPathComponent:self];
}

- (NSString *)pathWithType:(pathType)type
{
    NSString * s = nil ;
    switch (type) {
        case Documents:
            s = [@"Documents" stringByAppendingPathComponent:self];
            break;
        case tmp:
             s = [@"tmp" stringByAppendingPathComponent:self];
            break;
        case Caches:
             s = [@"Library/Caches" stringByAppendingPathComponent:self];
            break;
        case Preferences:
             s = [@"Library/Preferences" stringByAppendingPathComponent:self];
            break;
            
        default:
            break;
    }
    
    return [s path] ;
}


- (NSString *)bundleFile
{
    return [[NSBundle mainBundle] pathForResource:self
                                           ofType:nil];
}

- (UIImage *)bundleImage
{
    return [UIImage imageNamed:self];
}

- (BOOL)exist
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                isDirectory:nil];
}

- (BOOL)createFolder
{
    return [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
}

- (BOOL)isDirectory
{
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                         isDirectory:&isDirectory];
    
    return isDirectory;
}

- (BOOL)copyTo:(NSString *)path
{
    return [[NSFileManager defaultManager] copyItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                   toPath:[NSHomeDirectory() stringByAppendingPathComponent:path]
                                                    error:nil];
}

- (BOOL)moveTo:(NSString *)path
{
    return [[NSFileManager defaultManager] moveItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                   toPath:[NSHomeDirectory() stringByAppendingPathComponent:path]
                                                    error:nil];
}

- (BOOL)remove
{
    return [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                      error:nil];
}

- (NSArray *)enumeratorFolder
{
    if ([self isDirectory])
    {
        NSMutableArray *storeArray = [NSMutableArray array];
        
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:self];
        NSFileManager *localFileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
        
        NSString *file;
        while ((file = [dirEnum nextObject]))
        {
            [storeArray addObject:[[NSHomeDirectory() stringByAppendingPathComponent:self] stringByAppendingPathComponent:file]];
        }
        
        return storeArray;
    }
    else
    {
        return nil;
    }
}

- (void)enumeratorFolderEach:(void (^)(NSString *path))block
{
    if ([self isDirectory])
    {
        NSMutableArray *storeArray = [NSMutableArray array];
        
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:self];
        NSFileManager *localFileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
        
        NSString *file;
        while ((file = [dirEnum nextObject]))
        {
            [storeArray addObject:[self stringByAppendingPathComponent:file]];
        }
        
        [storeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj);
        }];
    }
}

- (void)enumeratorFolder:(void (^)(NSString *path))block
{
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:self
                                         isDirectory:&isDirectory];
    

    if (isDirectory)
    {
        NSArray *storeArray = [NSMutableArray array];
        
        NSString *docsDir = self;
        NSFileManager *localFileManager = [NSFileManager defaultManager];
//        NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
//        
//        NSString *file;
//        while ((file = [dirEnum nextObject]))
//        {
//            [storeArray addObject:file];
//        }
//
       storeArray = [localFileManager contentsOfDirectoryAtPath:docsDir error:nil];
        
        [storeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj);
        }];

    }

}

- (NSDictionary *)fileInfo
{
    return [[NSFileManager defaultManager] attributesOfItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                            error:nil];
}

- (int)fileSize
{
    return [[[[NSFileManager defaultManager] attributesOfItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                              error:nil] \
             objectForKey:@"NSFileSize"] intValue];
}

@end
