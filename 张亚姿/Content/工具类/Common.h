//
//  Common.h
//  思无邪
//
//  Created by guo on 15/9/17.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#ifndef ____Common_h
#define ____Common_h

#define kWidth  [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define kFrame  [[UIScreen mainScreen] bounds]

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//获取机子的高度
#define GetHeight [UIScreen mainScreen].bounds.size.height

//获取机子的宽度
#define Getwidth  [UIScreen mainScreen].bounds.size.width

//获取机子系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *判断是否大于等于ios7
 */
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
/**
 *判断是否大于等于ios8
 */
#define IS_IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

//获取软件版本号
#define  IOS_SoftWare [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

//当前语言文件
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//是否是3.5寸
#define IS_SCREEN_35_INCH ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
//是否是4寸
#define IS_SCREEN_4_INCH ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//获取机子路径的图片
#define GetImageURLWith(path) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",path] ofType:@"png"]]

//是否是IPAD
#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//RGB颜色
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]
/**
 *   弱化self
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
/**
 *  字体大小
 */
#define FontSize(CGFloat) [UIFont systemFontOfSize:CGFloat]


#endif
