//
//  CommendDefine.h
//  USA
//
//  Created by 永来 付 on 14/11/24.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#ifndef USA_CommendDefine_h
#define USA_CommendDefine_h


//  tools 工具类中的类方法，写成宏，方便调用

#define   UserDefaultObjectForKet(A)  [[NSUserDefaults standardUserDefaults] objectForKey:(A)]
#define   UserDefault                 [NSUserDefaults standardUserDefaults]
#define   TouchUpInside               UIControlEventTouchUpInside
#define   ESKArrayForLevel(A)         [UserDefaultObjectForKet(TestDataSoure) objectForKey:(A)] ;

//#define   UserDefaultObjectForKet(A)  [[NSUserDefaults standardUserDefaults] objectForKey:(A)]

#define   IsLogin                 [[User shareInstance] isLogin]
#define   UrlString(A)            [NSURL URLWithString:(A)]
#define   UserTelePhone           @"UserTelePhone"
#define   UserInfo                @"UserInfo"
#define   Device_token            @"Device_token"

#define   CurrentTimeString       [Tools currentTimeString]
#define   AppVersion              [Tools getApplicationVersion]
#define   Hiddenkeyboard          [Tools hiddenKeyboard]
#define   NoCacheImageNamed(A)    [UIImage noCacheImageNamed:(A)]
#define   ColorWithHexString(A)   [UIColor colorWithHexString:(A)]
#define   CreateLine              [Tools createLine]
#define   LineColor               [UIColor colorWithHexString:@"d8d8d8"]

#define   Notification_add(A,B)   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(A) name:B object:nil];
#define   Notification_remove(A)  [[NSNotificationCenter defaultCenter] removeObserver:self name:(A) object:nil];
#define   Notification_Post(A)    [[NSNotificationCenter defaultCenter] postNotificationName:(A) object:nil];
//
#define   Notification_PostWithObject(A,O)    [[NSNotificationCenter defaultCenter] postNotificationName:(A) object:(O)];

#define   UserDefault   [NSUserDefaults standardUserDefaults]
//**************************************************************************
#define ScreenHeight screenHeight()
#define ScreenWidth screenWith()

#define StateBarHeight 20
#define NavBarHeight   (44 + StateBarHeight)

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO  || isiPhone4)
#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOSVERSION  [[[UIDevice currentDevice] systemVersion] floatValue]


#pragma mark - Font
#define FONT_SIZE(f)            [UIFont systemFontOfSize:(f)]
#define FONT_BOLD_SIZE(f)       [UIFont boldSystemFontOfSize:(f)]
#define FONT_ITALIC_SIZE(f)     [UIFont italicSystemFontOfSize:(f)]


#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define Clear_Color             [UIColor clearColor]


#define isCanUseString(str)     ((str != nil) && [str isKindOfClass:[NSString class]] && [str length] > 0)

#define IsCanUserArray(A)       ([A isKindOfClass:[NSArray class]] &&[A count]>0)

#define isCanUseObj(str)        ((str != nil) && ![str isKindOfClass:[NSNull class]] )

#define APPDLE                  (AppDelegate*)[[UIApplication sharedApplication] delegate]




//#ifdef  DEBUG
//#define NSOBJECT_TOOLS_DEBUG YES
//#define PRINT_JOSN_STRING NO
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:\n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#define ALERT_LOG(msg)                                   [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]
//#define DEALLOC_LOG  - (void)dealloc{    NSLog(@"◊◊◊◊◊◊◊◊◊◊◊◊◊◊◊ dealloc Class:%@\n %@",self, NO ?  [NSString stringWithFormat:@"Class_Information:%@",[self Log:NO]] : EMPTY_STRING);}
//#else
//#define NSOBJECT_TOOLS_DEBUG NO
//#define PRINT_JOSN_STRING NO
//#define NSLog(FORMAT, ...) nil;
//#define ALERT_LOG(msg)
//#define DEALLOC_LOG
//#endif

 static  inline CGFloat  screenWith()
{
    static CGFloat width = 0;
    if (width == 0) {
        width  = [[UIScreen mainScreen] bounds].size.width ;
    }
 
    return width ;
}

static inline CGFloat screenHeight()
{
    static CGFloat height = 0 ;
    if (height == 0) {
        height = [[UIScreen mainScreen] bounds].size.height ;
    }
    return height ;
}



#endif
