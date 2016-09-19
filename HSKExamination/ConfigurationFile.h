//
//  ConfigurationFile.h
//  MyChild
//
//  Created by hu.yuan on 15/3/28.
//  Copyright (c) 2015年 hu.yuan. All rights reserved.
//

#ifndef MyChild_ConfigurationFile_h
#define MyChild_ConfigurationFile_h

#import "UrlPath.h"
#import "UIFont+Adaptation.h"


#define TestPaperPackageInfo     @"TestPaperPackageInfo.xml"

#define examination     @"examination"


#define  SideViewWidth    ScreenWidth 
#define  TabBarHeight      49
#define  BuNormal         UIControlStateNormal
#define  BuHighted        UIControlStateHighlighted
#define  BuTouchUpInside  UIControlEventTouchUpInside

#define TabBarController  @"TabBarController"
#define  KeyWindow         weakDictionaryObjectForKey(@"window")

#define BanerImage                      @"BanerImage.png"

#define BanerImageGif                   @"BanerImage.gif"

#define UserLocation                    @"UserLocation"

#define ToHomePageCon                   @"ToHomePageCon"

#define PeiSongAddress                  @"PeiSongAddress"
// 登陆超时
#define LoginChaoShiNotification        @"LoginChaoShiNotification"

#define StoreShopShiNotification        @"StoreShopShiNotification"

#define CanCalStoreShopfication         @"CanCalStoreShopfication"

#define LoginNotification               @"LoginNotification"

//app回到前台
#define EnterForegroundNotification     @"EnterForegroundNotification"
//app进入后台
#define EnterBackgroundNotification     @"EnterBackgroundNotification"
// 后台提示错误
#define BackgroundTipNotification       @"BackgroundTipNotification"

#define NetWorkNotWork                  @"NetWorkNotWork"

#define NetWorkWorkAwals                @"NetWorkWorkAwals"

#define RefrshDataNotification          @"RefrshDataNotification"
#define EndRfresh                       @"EndRfresh"
#define DeleteCart                      @"cart/del"

#define CenterText                      NSTextAlignmentCenter

#define TabBarSelectColor           RGBCOLOR(2, 105, 69)

#define PriceRedColor               ColorWithHexString(@"ff3146")

#define buBorderColor               ColorWithHexString(@"#39AC69")

#define blackRed                    ColorWithHexString(@"c63640")

#define lightGray6666               ColorWithHexString(@"666666")

#define DetailTextColor             ColorWithHexString(@"9A9A9A")

#define TitleTextColor              ColorWithHexString(@"333333")
//  自定义颜色
#define Font10           [UIFont fontWithSizeAdaptation:10]
#define Font20           [UIFont fontWithSizeAdaptation:20]
#define Font24           [UIFont fontWithSizeAdaptation:24]
#define Font18           [UIFont fontWithSizeAdaptation:18]
#define Font14           [UIFont fontWithSizeAdaptation:14]
#define Font24           [UIFont fontWithSizeAdaptation:24]
#define Font12           [UIFont fontWithSizeAdaptation:12]
#define Font16           [UIFont fontWithSizeAdaptation:16]
#define Font15           [UIFont fontWithSizeAdaptation:15]

//fontSize
#define FontSizeLarge 17.f
#define FontSizeNormal 15.f
#define FontSizeSmall 13.f


#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

//#define Alert(A) [ShowHUD showOnlyCustomInfoWithString:(A) \
//configParameter:^(ShowHUD *config) {} duration:2 inView:(((UIViewController *)[WeakDictionary objectForKey:TabBarController]).view)]

#define Alert(A) [WarningView showWarningText:(A)]

#define AlertWindow(A) [ShowHUD showOnlyCustomInfoWithString:(A) \
configParameter:^(ShowHUD *config) {} duration:3 inView:(((UIViewController *)[WeakDictionary objectForKey:TabBarController]).view)]

#define Toast(msg) AlertWindow(msg)

#endif
