//
//  AppDelegate.m
//  HSKExamination
//
//  Created by printer on 9/7/16.
//  Copyright © 2016 printer. All rights reserved.
//

#import "AppDelegate.h"
#import "SSZipArchive.h"
#import "NetWorking.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self checkData];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible] ;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] ;
    
    
    return YES;
}

- (void)checkData
{
    NSDictionary * dic= UserDefaultObjectForKet(TestDataSoure) ;
    
    if (!dic) {
        NSMutableDictionary * mudic = [NSMutableDictionary dictionaryWithCapacity:6];
     
        NSString * sourePath = [[NSBundle mainBundle] pathForResource:@"iPad" ofType:@"zip"];
        
        NSString *zipPath = sourePath ;
        
        NSString *destinationPath = IpadPath ;
        
        [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
        
        [destinationPath enumeratorFolder:^(NSString *path) {
//            NSLog(@"%@",path) ;
            if ([path isEqualToString:@"H11116"]) {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"1"}];
                [mudic setObject:arr forKey:@"1"];
            }else if  ([path isEqualToString:@"H21116"])
            {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"3"}];
                [mudic setObject:arr forKey:@"2"];
            
            }
            else if  ([path isEqualToString:@"H31114"])
            {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"5"}];
                [mudic setObject:arr forKey:@"3"];

            }
            else if  ([path isEqualToString:@"H41114"])
            {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"7"}];
                [mudic setObject:arr forKey:@"4"];

            }
            else if  ([path isEqualToString:@"H51114"])
            {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"10"}];
                [mudic setObject:arr forKey:@"5"];

            }
            else if  ([path isEqualToString:@"H61114"])
            {
                NSMutableArray * arr = [NSMutableArray array];
                [arr addObject:@{FileName:path,@"id":@"13"}];
                [mudic setObject:arr forKey:@"6"];

            }
            
        }];
        
        [UserDefault setObject:mudic forKey:TestDataSoure];
        [UserDefault synchronize];
    }
    
    [self checkUpData];
}

- (void)checkUpData
{
    [NetWorking downLoadWithUrl:@"http://mnks.cnhsk.org/MnMoblie/json.json" completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"%@",filePath) ;
        if (error == nil) {
            NSData * data = [NSData dataWithContentsOfURL:filePath];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [User shareInstance].testDownLoadUrl = dic[@"server"]; ;
        
            NSArray * arr = dic[@"hsk"];
            
            NSDictionary * localData = UserDefaultObjectForKet(TestDataSoure) ;
            
            for (NSDictionary * dic in arr) {
                NSString * level = [NSString stringWithFormat:@"%@", dic[@"level"]] ;
                NSArray * localPacks = localData[level];
                NSArray * packages = dic[@"packages"];
                for (NSDictionary * pack in packages) {
                    NSString * packId = pack[@"id"] ;
                    
                    bool b = NO ;
                    for (NSDictionary * localPack in localPacks) {
                        if (packId.intValue == [localPack[@"id"] intValue]) {
                            b = YES ;
                            break ;
                        }
                    }
                    
                    if (!b) {
                        // 如果本地没有而服务器有，就要下载
                        [self downLoadPackWithPackName:pack andLevel:level] ;
                    }
                }
            }
        }
    }];
}

- (void)downLoadPackWithPackName:(NSDictionary *)pack andLevel:(NSString *)level
{

    [NetWorking downLoadWithUrl:[[User shareInstance].testDownLoadUrl stringByAppendingString:pack[@"name"]] completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            NSMutableDictionary * muDic = [NSMutableDictionary dictionaryWithDictionary:UserDefaultObjectForKet(TestDataSoure)];
            NSMutableArray * array = [NSMutableArray arrayWithArray:[muDic objectForKey:level]];
            NSString * packName = [pack[@"name"] componentsSeparatedByString:@"."][0];
            NSFileManager * manger = [NSFileManager defaultManager];
            [manger createDirectoryAtPath:[IpadPath stringByAppendingPathComponent:packName] withIntermediateDirectories:YES attributes:nil error:nil];
            NSString * zipPath = [filePath.absoluteString substringFromIndex:7] ;
            NSString * destinationPath = [IpadPath stringByAppendingPathComponent:packName] ;
            [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
            [array addObject:@{FileName:packName,@"id":pack[@"id"]}];
            [muDic setObject:array forKey:level];
            [UserDefault setObject:muDic forKey:TestDataSoure];
            [UserDefault synchronize];
            [manger removeItemAtURL:filePath error:nil];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
