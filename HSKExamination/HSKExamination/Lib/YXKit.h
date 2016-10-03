/*---------------------------------------------------------------------------------*/
/*
 *  所有用到的category文件
 */
/*---------------------------------------------------------------------------------*/

#import <UIKit/UIKit.h>
#import "Tools.h"
// NSArray
#import "NSArray+JSON.h"                          // 转换成JSON格式数据
#import "NSArray+Sort.h"                          // 对数组排序

// UIFont
#import "UIFont+CustomFont.h"                     // 自定义字体

// NSData
#import "NSData+JSON.h"                           // 将JSON转换为数组或者字典
#import "NSData+MetaData.h"                       // 获取图片Data的Meta数据
#import "NSData+String.h"                         // 将NSData转换为字符串
#import "NSData+MD5.h"                            // 获取NSData的MD5值
#import "NSData+Binary.h"                         // 将不可识别二进制文件转换为可识别的文本文件

// NSDictionary
#import "NSDictionary+JSON.h"                     // 转换成JSON格式数据
#import "NSDictionary+Sort.h"                     // 对字典的键值排序
#import "NSDictionary+ToModelFile.h"              // 将字典转换成Model

// NSString
#import "NSString+Data.h"                         // 将NSString转换为NSData
#import "NSString+DES.h"                          // DES加密字符串
#import "NSString+RichText.h"                     // 由字符串产生富文本
#import "NSString+File.h"                         // 字符串直接产生路径
#import "NSString+MD5.h"                          // 产生MD5值
#import "NSString+CustomFont.h"                   // 自定义字体
#import "NSString+Binary.h"                       // 将字符串转换成不可识别二进制文件
#import "NSString+WeakDictionary.h"               // 从字符串恢复对象
#import "NSString+UIPasteboard.h"                 // 将文本复制到粘贴板
#import "NSString+Telephone.h"                    // 判断字符串是否是合法的手机号码,直接根据字符串打电话
#import "NSString+NetString.h"                    // 转换成网络字符串
#import "NSString+Appending.h"                    // 追加字符串
#import "NSString+Chara.h"

// UIImage
#import "UIImage+MetaData.h"                      // 获取UIImage的MetaData

// NSObject
#import "NSObject+Runtime.h"                      // runtime
#import "NSObject+FastCoder.h"                    // 文件快速存储
#import "NSObject+Properties.h"                   // runtime赋值对象
#import "NSObject+WeakDictionary.h"               // 存储到弱引用字典
#import "NSObject+WeakRelated.h"                  // 让一个对象与另外一个对象产生关联
#import "NSObject+NSNotificationCenter.h"         // 简化通知中心设定

// UIViewController
#import "UIViewController+TitleTextAttributes.h"  // 设置导航栏控制器标题
#import "UIViewController+CurrentController.h"    // 获取当前的控制器
#import "UIViewController+UIRectEdge.h"           // 解决UITableView在UINavigationController中的顶部留白问题

// UINavigationController
#import "UINavigationController+POP.h"            // pop到指定的控制器去
#import "UINavigationController+Hide.h"           // 隐藏导航栏控制器

// UIView
#import "UIView+RelativeToUIScreen.h"             // 换算当前view的尺寸与屏幕尺寸之间的关系
#import "UIView+ConvertRect.h"                    // 当前view在另外一个view中的rect值
#import "UIView+RectWithImage.h"                  // 根据图片size来设置view的size值
#import "UIView+SetRect.h"                        // 便利的设置rect值
#import "UIView+BackgroundView.h"                 // 快速设置渐变的view
#import "UIView+AddToView.h"                      // 便利的获取view插入view
#import "UIView+Init.h"                           // 初始化相关的一些方法

// UIWindow
#import "UIWindow+Window.h"                       // 获取UIWindow

// UIButton
#import "UIButton+Init.h"                         // UIButton的初始化便利方法

/*---------------------------------------------------------------------------------*/
/*
 *  所有用到的常用文件
 */
/*---------------------------------------------------------------------------------*/
#import "NETWorkConnection.h"                     // 网络连接
#import "NETWorkRequest.h"                        // 网络请求
#import "NETWorkPicUpload.h"                      // 图片上传
#import "TransformDictionary.h"                   // 将json串转换成Model文件
#import "YXGCD.h"                                 // GCD库
#import "ShowHUD.h"                               // 显示各种状态
#import "YXTimer.h"                               // 定时器
#import "YXEasing.h"                              // 缓动函数
#import "Easing.h"                                // 缓动函数
#import "UITableViewCell+Line.h"

/*---------------------------------------------------------------------------------*/
/*
 *  自定义控件
 */
/*---------------------------------------------------------------------------------*/
#import "BackgroundView.h"                        // 渐变背景的view
