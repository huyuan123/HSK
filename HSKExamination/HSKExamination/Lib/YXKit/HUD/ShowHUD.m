//
//  ShowHUD.m
//  TestHUD
//
//  Created by YouXianMing on 14-9-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "ShowHUD.h"
#import "LoadingRotateView.h"

#ifdef DEBUG
#define ShowHUD_DLog(fmt, ...) NSLog((@"ShowHUD.m:%s:%d" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ShowHUD_DLog(...)
#endif

@interface ShowHUD ()<MBProgressHUDDelegate>

{
    MBProgressHUD   *_hud;
}

@end

@implementation ShowHUD

- (instancetype)initWithView:(UIView *)view
{
    if (view == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _hud = [[MBProgressHUD alloc] initWithView:view];
        _hud.delegate                  = self;                       // 设置代理
        _hud.animationType             = MBProgressHUDAnimationFade; // 默认动画样式
        _hud.removeFromSuperViewOnHide = YES;                        // 该视图隐藏后则自动从父视图移除掉
        
        [view addSubview:_hud];
    }
    return self;
}

- (void)hide:(BOOL)hide afterDelay:(NSTimeInterval)delay
{
    [_hud hide:hide afterDelay:delay];
}

- (void)hide
{
    [_hud hide:YES];
}

- (void)show:(BOOL)show
{
    // 根据属性判断是否要显示文本
    if (_text != nil && _text.length != 0) {
        _hud.labelText = _text;
    }
    
    // 设置文本字体
    if (_textFont) {
        _hud.labelFont = _textFont;
    }
    
    // 如果设置这个属性,则只显示文本
    if (_showTextOnly == YES && _text != nil && _text.length != 0) {
        _hud.mode = MBProgressHUDModeText;
    }
    
    // 设置背景色
    if (_backgroundColor) {
        _hud.color = _backgroundColor;
    }
    
    // 文本颜色
    if (_labelColor) {
        _hud.labelColor = _labelColor;
    }
    
    // 设置圆角
    if (_cornerRadius) {
        _hud.cornerRadius = _cornerRadius;
    }
    
    // 设置透明度
    if (_opacity) {
        _hud.opacity = _opacity;
    }
    
    // 自定义view
    if (_customView) {
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.customView = _customView;
    }
    
    // 边缘留白
    if (_margin > 0) {
        _hud.margin = _margin;
    }
    
    [_hud show:show];
}

#pragma mark - HUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_hud removeFromSuperview];
    _hud = nil;
}

#pragma mark - 重写setter方法
@synthesize animationStyle = _animationStyle;
- (void)setAnimationStyle:(HUDAnimationType)animationStyle
{
    _animationStyle    = animationStyle;
    _hud.animationType = (MBProgressHUDAnimation)_animationStyle;
}
- (HUDAnimationType)animationStyle
{
    return _animationStyle;
}

#pragma mark - 便利的方法
+ (void)showTextOnly:(NSString *)text
     configParameter:(ConfigShowHUDBlock)config
            duration:(NSTimeInterval)sec
              inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.showTextOnly = YES;
    hud.cornerRadius = 4.f;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    // 延迟sec后消失
    [hud hide:YES afterDelay:sec];
}

+ (void)showText:(NSString *)text
 configParameter:(ConfigShowHUDBlock)config
        duration:(NSTimeInterval)sec
          inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.cornerRadius = 4.f;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    // 延迟sec后消失
    [hud hide:YES afterDelay:sec];
}


+ (void)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
       configParameter:(ConfigShowHUDBlock)config
              duration:(NSTimeInterval)sec
                inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    hud.cornerRadius = 4.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = viewBlock();
    
    // 显示
    [hud show:YES];
    
    [hud hide:YES afterDelay:sec];
}


+ (instancetype)showTextOnly:(NSString *)text
             configParameter:(ConfigShowHUDBlock)config
                      inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.cornerRadius = 4.f;
    hud.showTextOnly = YES;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];

    return hud;
}

+ (instancetype)showText:(NSString *)text
         configParameter:(ConfigShowHUDBlock)config
                  inView:(UIView *)view
{
    if (text == nil) {
        text = @"" ;
    }
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.margin       = 10.f;
    hud.cornerRadius = 4.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    return hud;
}

+ (instancetype)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
               configParameter:(ConfigShowHUDBlock)config
                        inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    hud.cornerRadius = 4.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = viewBlock();
    
    // 显示
    [hud show:YES];
    
    return hud;
}

+ (void)showOnlyCustomInfoWithString:(NSString *)str
                     configParameter:(ConfigShowHUDBlock)config
                            duration:(CGFloat)duration
                              inView:(UIView *)view {
    NSString *messge = str;
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0 ;
    label.font          = [UIFont systemFontOfSize:18.f];
    label.textColor     = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    hud.cornerRadius = 4.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = label;
    
    // 显示
    [hud show:YES];
    
    [hud hide:YES afterDelay:duration];
}

+ (void)showOnlyCustomInfoWithString:(NSString *)str
                           textColor:(UIColor *)color
                     configParameter:(ConfigShowHUDBlock)config
                            duration:(CGFloat)duration
                              inView:(UIView *)view {
    NSString *messge = str;
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0 ;
    label.font          = [UIFont systemFontOfSize:18.f];
    label.textColor     = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    hud.cornerRadius = 4.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = label;
    
    // 显示
    [hud show:YES];
    
    [hud hide:YES afterDelay:duration];
}


+ (void)showLemonTaryLoadingWithText:(NSString *)str
                            duration:(CGFloat)duration
                              inView:(UIView *)view {
    
    
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    
    
    LoadingRotateView *loadingView = [[LoadingRotateView alloc] initWithFrame:CGRectZero];
    loadingView.center             = containView.middlePoint;
    loadingView.y                 -= 6;
    [containView addSubview:loadingView];
    
    
    NSString *messge = str;
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0 ;
    label.font          = [UIFont systemFontOfSize:16.f];
    label.textColor     = [UIColor colorWithHexString:@"4a807f"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    [containView addSubview:label];
    label.center        = containView.middlePoint;
    label.y             = loadingView.height + 35;
    containView.height += label.height;

    
    ShowHUD *hud        = [[ShowHUD alloc] initWithView:view];
    hud.backgroundColor = [[UIColor colorWithHexString:@"9cdfde"] colorWithAlphaComponent:0.96];
    hud.margin          = 10.f;
    hud.cornerRadius    = 4.f;
    hud.animationStyle  = MBProgressHUDAnimationZoom;
    hud.customView      = containView;
    
    
    // 显示
    [hud show:YES];
    [hud hide:YES afterDelay:duration];
}

+ (instancetype)showLemonTaryLoadingWithText:(NSString *)str
                                      inView:(UIView *)view {
    str = @"Loading..." ;
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    
    
    LoadingRotateView *loadingView = [[LoadingRotateView alloc] initWithFrame:CGRectZero];
    loadingView.center             = containView.middlePoint;
    loadingView.y                 -= 6;
    [containView addSubview:loadingView];
    
    
    NSString *messge    = str;
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0;
    label.font          = [UIFont systemFontOfSize:16.f];
    label.textColor     = [UIColor colorWithHexString:@"4a807f"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    [containView addSubview:label];
    label.center        = containView.middlePoint;
    label.y             = loadingView.height + 35;
    containView.height += label.height;
    
    
    ShowHUD *hud        = [[ShowHUD alloc] initWithView:view];
    hud.backgroundColor = [[UIColor colorWithHexString:@"9cdfde"] colorWithAlphaComponent:0.96];
    hud.margin          = 10.f;
    hud.cornerRadius    = 4.f;
    hud.animationStyle  = MBProgressHUDAnimationZoom;
    hud.customView      = containView;
    
    
    // 显示
    [hud show:YES];
    return hud;
}


+ (instancetype)showLemonTaryLoadingInView:(UIView *)view {
    NSString *str       = @"Loading..." ;
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 100)];
    
    LoadingRotateView *loadingView = [[LoadingRotateView alloc] initWithFrame:CGRectZero];
    loadingView.center             = containView.middlePoint;
    loadingView.y                 -= 15;
    [containView addSubview:loadingView];
    
    
    NSString *messge    = str;
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0;
    label.font          = [UIFont systemFontOfSize:16.f];
    label.textColor     = [UIColor colorWithHexString:@"4a807f"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    [containView addSubview:label];
    label.center        = containView.middlePoint;
    label.y             = loadingView.height + 23;
    
    ShowHUD *hud        = [[ShowHUD alloc] initWithView:view];
    hud.backgroundColor = [[UIColor colorWithHexString:@"9cdfde"] colorWithAlphaComponent:0.96];
    hud.margin          = 10.f;
    hud.cornerRadius    = 4.f;
    hud.animationStyle  = MBProgressHUDAnimationZoom;
    hud.customView      = containView;
    
    
    // 显示
    [hud show:YES];
    return hud;
}





+ (void)showLemonTaryLoadingWithOnlyText:(NSString *)str
                                duration:(CGFloat)duration
                                  inView:(UIView *)view {
    NSString *messge = str;
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    label.numberOfLines = 0;
    label.font          = [UIFont systemFontOfSize:16.f];
    label.textColor     = [UIColor colorWithHexString:@"4a807f"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = messge;
    [label sizeToFit];
    
    ShowHUD *hud        = [[ShowHUD alloc] initWithView:view];
    hud.backgroundColor = [[UIColor colorWithHexString:@"9cdfde"] colorWithAlphaComponent:0.96];
    hud.margin          = 10.f;
    hud.cornerRadius    = 4.f;
    hud.animationStyle  = MBProgressHUDAnimationZoom;
    hud.customView      = label;
    
    // 显示
    [hud show:YES];
    [hud hide:YES afterDelay:duration];

}

- (void)dealloc {

}

@end
