//
//  MyHelper.h
//  思无邪
//
//  Created by guo on 15/9/18.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@interface MyHelper : NSObject
@property (strong, nonatomic) NSString *qiudushu;
/**
 *  单例
 */
+ (instancetype)ShareMyHelper;

/**
 ********************************************** 基础控件封装 *********************************************
 */
#pragma mark - Label
+ (UILabel *)createLabelWith:(NSString *)text textColor:(UIColor *)textColor frame:(CGRect)frame font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor textAlignment:(NSTextAlignment)textAlignment userInteractionEnabled:(BOOL)userInteractionEnabled adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth;
#pragma mark - ImageView
+ (UIImageView *)createImageViewWith:(NSString *)imageName frame:(CGRect)frame userInteractionEnabled:(BOOL)userInteractionEnabled;
#pragma mark - Button
+ (UIButton *)createButtonWith:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundImage:(NSString *)backGroundImage image:(NSString *)imageName backGroundColor:(UIColor *)color font:(UIFont *)font frame:(CGRect)frame setUserInteractionEnabled:(BOOL)setUserInteractionEnabled buttonWithType:(UIButtonType)buttonWithType;
#pragma mark - UITextView
+ (UITextView *)createTextViewWith:(NSString *)text textColor:(UIColor *)textColor frame:(CGRect)frame font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor keyboardType:(UIKeyboardType)keyboardType scrollEnabled:(BOOL)scrollEnabled autoresizingMask:(UIViewAutoresizing)UIViewAutoresizingFlexibleHeight textAlignment:(NSTextAlignment)textAlignment editable:(BOOL)editable;
#pragma mark - UITextField
+ (UITextField *)createTextFileWith:(UIColor *)textColor frame:(CGRect)frame font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyboardType placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry clearButtonMode:(UITextFieldViewMode)clearButtonMode autoresizingMask:(UIViewAutoresizing)autoresizingMask setEnabled:(BOOL)setEnabled;
#pragma mark - 创建UISlider
+ (UISlider *)createSliderWith:(CGRect)frame userInteractionEnabled:(BOOL)userInteractionEnabled value:(float)value minimumValue:(float)minimumValue maximumValue:(float)maximumValue target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundColor:(UIColor *)backGroundColor continuous:(BOOL)continuous minimumTrackTintColor:(UIColor *)minimumTrackTintColor maximumTrackTintColor:(UIColor *)maximumTrackTintColor thumbTintColor:(UIColor *)thumbTintColor;

/**
 * 功能描述: 判断字符串是否为空
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isEmpty:(NSString*)string;

/**
 * 功能描述: // 验证手机号是否合法
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 注册邮箱格式是否正确
+ (BOOL)emailIsLegal:(NSString *)email;

/**
 *  手机号是否合法
 */
+(BOOL)isMobileNumberClassification;
/**
 *   身份证是否合法
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

/**
 *  银行卡号是否合法
 */
+(BOOL) checkCardNo:(NSString*) cardNo;
/**
 *  MD5 加密
 */
+(NSString *)md5HexDigest:(NSString*)input;

/**
 *  由数字和26个英文字母组成的字符串
 *
 *  @param idCard 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForNumberAndCase:(NSString *)data;


/**
 *  校验只能输入26位小写字母
 *
 *  @param 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForLowerCase:(NSString *)data;

/**
 *  校验只能输入26位大写字母
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForUpperCase:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 *
 *  @param data 字符串
 *
 *  @return 结果
 */
+ (BOOL) checkForLowerAndUpperCase:(NSString *)data;

/**
 *  是否含有特殊字符(%&’,;=?$\等)
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForSpecialChar:(NSString *)data;
/**
 * 判断字符串是否为纯数字
 */
+(BOOL)PanDuanChunNumber:(NSString *)mString;
/**
 *  字符串中是否有中文
 */
+ (BOOL)isHaveChineseInString:(NSString *)string;
/**
 *  获取字符串首字符
 */
+ (NSString *)firstCharacterWithString:(NSString *)string;
/**
 *  返回没有 .00  后缀的字符串
 */
+ (NSString *)RetBackWithoutZero:(NSString *)mString;

/*!
 * get device ip address  获取手机Ip
 */
+ (NSString *)deviceIPAdress;

/**
 *  获取手机外网地址
 */
+(NSString *)getOutIpAdress;
/**
 *  红线
 */
+ (UIView *)getLineView;

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert;

/**
 * 功能描述: 返回一个UIScrollView属性自带需要改自行修改
 * 输入参数: nil
 * 返 回 值: UIScrollView
 */
+ (UIScrollView*)getScrollView;

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion;

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork;

/**
 * 功能描述: 清除ios7或以上TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;

/**
 * 功能描述: 清除ios7或以上 cell 向右多20像素
 * 输入参数: N/A
 * 返 回 值: N/A    效果不明显
 */
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView;

/**
 * 功能描述: 高斯白边模糊效果
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+(UIImage *)trainBackImg:(NSString *)imgName;


//为按钮添加边框
+ (void)addBorderToButton:(UIButton *)btn
              BorderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             cornerRadius:(CGFloat)corneerRadius;

/**
 *  照片旋转的问题
 */
+(UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  用来判断是否有访问手机联系人权限
 */
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;

/**
// * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
// */
//+ (BOOL)checkPhotoLibraryAuthorizationStatus;
//
///**
// * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
// */
//+ (BOOL)checkCameraAuthorizationStatus;
/**
 *  生成存放十个随机数的数组
 */
+ (NSArray *)RetbackOccasionalNumArr;
/**
 *  生成存放随机数的数组
 */
+ (NSArray *)RetbackOccasionalNummerArr:(NSString *)mEndValue;
/**
 *  磁盘总空间
 */
+ (CGFloat)diskOfAllSizeMBytes;
/**
 * 磁盘可用空间大小
 */
+ (CGFloat)diskOfFreeSizeMBytes;
/**
 *  获取文件大小
 */
+ (long long)fileSizeAtPath:(NSString *)filePath;
/**
 *  图片滤镜处理
 */
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

/**
 * 全屏截图
 */
+ (UIImage *)shotScreen;
/**
 * 压缩图片到指定尺寸大小
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
/**
 * 获取UUID 手机唯一标识符 （存储。。。。）
 */
+ (NSString *)getUUID;
@end
