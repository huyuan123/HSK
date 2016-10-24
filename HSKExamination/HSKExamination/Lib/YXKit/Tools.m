//
//  Tools.m
//  USA
//
//  Created by 永来 付 on 14/11/24.
//  Copyright (c) 2014年 fuhuaqi. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"

@implementation Tools

//显示不正确的信息
+ (void)alertViewShow:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
    
}
//计算label的位置以及大小

+ (CGRect)labelFrameForString:(UILabel*)label;
{
    CGSize contentSize =
    [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : label.font} context:nil].size;
    return CGRectMake(label.x, label.y, label.width, contentSize.height);
}



+ (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString* fileDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    fileDirectory = [[fileDirectory stringByAppendingPathComponent:_fileName]stringByAppendingPathExtension:_type];
    return fileDirectory;
}


+ (void)clearDisk
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                    
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                   }
                   ) ;
}

+ (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (NSString*)currentTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return timeStr;
}


//获取版本
+ (NSString*)getApplicationVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *ver = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return ver;
    
}

+ (void)hiddenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (BOOL)saveIconImage:(UIImage *)image
{
    NSData * data = UIImageJPEGRepresentation(image, 0.85) ;
    [data writeToFile:[self userIconpath] atomically:YES];
    return YES ;
}

+ (UIImage *)iconImage
{
    
    return [UIImage imageWithContentsOfFile:[self userIconpath]];
}


+ (NSString *)userIconpath ;
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"icon.jpg"];
    return fullPath ;
}

// 显示提示框
+ (void) showHUD:(NSString*)text
{
    if ([text isEqualToString:@"该区县不存在"]) {
        return ;
    }
    
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:del.window];
    HUD.color = RGBACOLOR(29, 39, 39, 0.7);
    [del.window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"检测更新表情.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}


+ (CGFloat)distanceWithPoint1:(CGPoint)p1 andPoint2:(CGPoint)p2
{
    float x = p1.x - p2.x ;
    float y = p1.y - p2.y ;
    return sqrt(x*x + y*y) ;
}

+ (MBProgressHUD*)showProgressWithTitle:(NSString*)title
{
    
    MBProgressHUD *progress = [[MBProgressHUD alloc] init];
    [[[UIApplication sharedApplication].delegate window] addSubview:progress];
    progress.removeFromSuperViewOnHide = YES;
    if (!isCanUseString(title)) {
        progress.labelText = @"正在加载";
    } else {
        progress.labelText = title;
    }
    
    [progress show:YES];
    
    return progress ;
    
}

+ (void)hiddenProgress:(MBProgressHUD*)progress
{
    [progress hide:YES];
}

+ (UIView*)createLine
{
    CGFloat lineWidth = 0 ;
    if (isiPhone6p) {
        lineWidth = 0.2 ;
    }else
    {
        lineWidth =  0.5 ;
    }
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, ScreenWidth, lineWidth);
    line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    return line ;
}

@end


@implementation UIViewController (RemoveSelfPushOther)

- (void)pushWithRemoveSelf:(UIViewController *)viewController {
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs addObject:viewController];
    [vcs removeObject:self];
    [self.navigationController setViewControllers:vcs animated:YES];
}

@end

@implementation  UIImage(Extend)

// 无缓存读取图片
+ (UIImage *)noCacheImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
    return image;
}

-(UIImage*)scaleToSize:(CGSize)size
{
    //等比例大小(缩的很丑)
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end


#pragma mark - UIImage+ResizableImage
@implementation UIImage (ResizableImageAndNoCashedImage)

-(UIImage*)resizedImageWithCapInsets:(UIEdgeInsets)capInsets{
    if(IOSVERSION >= 6){
        return [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    } else {
        
        return [self resizableImageWithCapInsets:capInsets];
    }
}

-(UIImage*)scaleToSize:(CGSize)size
{
    //等比例大小(缩的很丑)
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)writeToalbum
{
   UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

}

@end


@implementation UIColor (Color16ToRgb)

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end

@implementation UIButton (SetBackgroundImage)

- (void)setBackgroundSmallImageNor:(UIImage *)norImage smallImagePre:(UIImage *)preImage {
    
    norImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 7, 10, 10) resizingMode:UIImageResizingModeTile];
    preImage = [preImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 7, 10, 10) resizingMode:UIImageResizingModeTile];
    [self setBackgroundImage:norImage forState:UIControlStateNormal];
    [self setBackgroundImage:preImage forState:UIControlStateHighlighted];
}

@end


@implementation  NSString (size)
- (CGSize)sizeForFont:(UIFont *)font andSize:(CGSize)size
{
    
  return   [self boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : font} context:nil].size;
    
}


@end

