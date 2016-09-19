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
//#define   AlertViewShow(A)        [Tools alertViewShow:(A)]
#define   LabelFrameForString(A)  [Tools labelFrameForString:(A)]
#define   CurrentTimeString       [Tools currentTimeString]
#define   AppVersion              [Tools getApplicationVersion]
#define   Hiddenkeyboard          [Tools hiddenKeyboard]
#define   NoCacheImageNamed(A)    [UIImage noCacheImageNamed:(A)]
#define   ColorWithHexString(A)   [UIColor colorWithHexString:(A)]
#define   Call(A)                 callPhoneWithNumber(A)
#define   CreateLine              [UIView createLine]
#define SAFE_STR(x) ((x)==nil)?@"":(x)


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
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define IOSVERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

#define RealMainHeight (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (ScreenHeight - 44):(MainHeight - 44))

#define NavOffsetHeight (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) ? StateBarHeight : 0)
#define ScreenTop  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?64:44

#define SCREENSIZE  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [UIScreen mainScreen].currentMode.size : CGSizeZero)
#define IS_RETINA   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 320 : NO)


#pragma mark - Font
#define FONT_SIZE(f)            [UIFont systemFontOfSize:(f)]
#define FONT_BOLD_SIZE(f)       [UIFont boldSystemFontOfSize:(f)]
#define FONT_ITALIC_SIZE(f)     [UIFont italicSystemFontOfSize:(f)]


#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define Clear_Color             [UIColor clearColor]


#define NUMBER_int(x)			[NSNumber numberWithInt:x]


#define isCanUseString(str)     ((str != nil) && [str isKindOfClass:[NSString class]] && [str length] > 0)

#define IsCanUserArray(A)       ([A isKindOfClass:[NSArray class]] &&[A count]>0)


#define isCanUseObj(str)        ((str != nil) && ![str isKindOfClass:[NSNull class]] )

#define APPDLE                  (AppDelegate*)[[UIApplication sharedApplication] delegate]

#pragma mark color
#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]




#ifdef DEBUG
#define NSOBJECT_TOOLS_DEBUG YES
#define PRINT_JOSN_STRING NO
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:\n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define ALERT_LOG(msg)                                   [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]
#define DEALLOC_LOG  - (void)dealloc{    NSLog(@"◊◊◊◊◊◊◊◊◊◊◊◊◊◊◊ dealloc Class:%@\n %@",self, NO ?  [NSString stringWithFormat:@"Class_Information:%@",[self Log:NO]] : EMPTY_STRING);}
#else
#define NSOBJECT_TOOLS_DEBUG NO
#define PRINT_JOSN_STRING NO
#define NSLog(FORMAT, ...) nil;
#define ALERT_LOG(msg)
#define DEALLOC_LOG
#endif

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
