//
//  MyHelper.m
//  思无邪
//
//  Created by guo on 15/9/18.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "MyHelper.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>
#import <CommonCrypto/CommonDigest.h>  //针对MD5加密需要的头文件
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@import AVFoundation;

@implementation MyHelper


/**
 *  创建单例
 */
+ (instancetype)ShareMyHelper
{
    static MyHelper *__shareFont = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareFont = [[MyHelper alloc] init];
    });
    return __shareFont;
}
/**
 *   初始化
 */
- (instancetype)init
{
    if (self = [super init])
    {
        _qiudushu = @"邱读书";
    }
    return self;
}

 
+ (BOOL)isEmpty:(NSString*)string
{
    if (string == nil)
    {
        return YES;
    }
    else if (string == NULL)
    {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([string  isEqualToString:@""])
    {
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    else if ([string isEqualToString:@"<null>"]
             || [string isEqualToString:@"null"]
             || [string isEqualToString:@"(null)"]
             ||[string isEqualToString:@"NULL"]
             || [string isEqualToString:@"<NULL>"]
             || [string isEqualToString:@"(NULL)"])
    {
        return YES;
    }
    return NO;
}

/**
 *  获取红线
 *
 *  @return View
 */
+ (UIView *)getLineView{
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, kWidth, 1.0f);
    lineView.backgroundColor = [UIColor redColor];
    return lineView;
}

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert
{
    NSString *cString = [[iStringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor yellowColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


/**
 * 功能描述: 返回一个UIScrollView属性自带需要改自行修改
 * 输入参数: nil
 * 返 回 值: UIScrollView
 */
+ (UIScrollView*)getScrollView
{
    UIScrollView *scr_Main = [[UIScrollView alloc]init];
    scr_Main.backgroundColor = [MyHelper colorWithHexString:@"#eeeeeb"];
    scr_Main.bounces = YES;
    scr_Main.pagingEnabled = YES;
    scr_Main.clipsToBounds = YES;
    scr_Main.showsHorizontalScrollIndicator = NO;
    scr_Main.showsVerticalScrollIndicator = NO;
    scr_Main.scrollsToTop = NO;
    return scr_Main;
}

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *oAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return oAppVersion;
}

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"连不上网");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 * 功能描述: 清除ios7或以上TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [iTableView setTableFooterView:view];
}

/**
* 功能描述: 清除ios7或以上 cell 向右多20像素
* 输入参数: N/A
* 返 回 值: N/A
*/
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView
{
    if([iTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [iTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([iTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [iTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 * 功能描述: 高斯白边模糊效果
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+(UIImage *)trainBackImg:(NSString *)imgName{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [[CIImage alloc]initWithImage:[UIImage imageNamed:imgName]];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

/**
 * 功能描述: // 验证手机号是否合法
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum]) {
        return YES;
    }
    return NO;
}

// 注册邮箱格式是否正确
+ (BOOL)emailIsLegal:(NSString *)email
{
    
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL bEmail = [emailCheck evaluateWithObject:email];
    return bEmail;
}

//为按钮添加边框
+ (void)addBorderToButton:(UIButton *)btn
              BorderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             cornerRadius:(CGFloat)corneerRadius
{
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    btn.layer.cornerRadius = corneerRadius;
    btn.layer.masksToBounds = YES;
}

/**
 *  手机号是否合法
 */
+(BOOL)isMobileNumberClassification
{
    /*
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if (([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        || ([regextestphs evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *   身份证是否合法
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
/**
 *  银行卡号是否合法
 */
+(BOOL) checkCardNo:(NSString*) cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 *   获取手机Ip
 */
+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    NSLog(@"手机的IP是：%@", address);
    return address;
}


/**
 *  获取手机外网地址
 */
+(NSString *)getOutIpAdress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    //     NSString *outstring = [NSString stringWithFormat:@"x:x:x:x:x:x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"xxxxxx", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

/**
 *  照片旋转的问题
 */
+(UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/**
 *  MD5 加密
 */
+(NSString *)md5HexDigest:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, input.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 * 判断字符串是否为纯数字
 */
+(BOOL)PanDuanChunNumber:(NSString *)mString
{
    NSString * regex   = @"(^[0-9]*$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL allIsNum = [pred evaluateWithObject:mString];
    return allIsNum;
}


+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                     });  
                                                 });  
    }
    else
    {
        block(YES);
    }
    
}

//+ (BOOL)checkPhotoLibraryAuthorizationStatus
//{
//    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)])
//    {
//        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
//        if (ALAuthorizationStatusDenied == authStatus ||
//            ALAuthorizationStatusRestricted == authStatus)
//        {
//            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
//            return NO;
//        }
//    }
//    return YES;
//}
//
//+ (BOOL)checkCameraAuthorizationStatus
//{
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
////        kTipAlert(@"该设备不支持拍照");
//        return NO;
//    }
//    
//    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (AVAuthorizationStatusDenied == authStatus ||
//            AVAuthorizationStatusRestricted == authStatus) {
//            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
//            return NO;
//        }
//    }
//    
//    return YES;
//}
//
//+ (void)showSettingAlertStr:(NSString *)tipStr{
//    //iOS8+系统下可跳转到‘设置’页面，否则只弹出提示窗即可
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
//        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:tipStr];
//        [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
//        [alertView bk_addButtonWithTitle:@"设置" handler:nil];
//        [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
//            if (index == 1) {
//                UIApplication *app = [UIApplication sharedApplication];
//                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([app canOpenURL:settingsURL]) {
//                    [app openURL:settingsURL];
//                }
//            }
//        }];
//        [alertView show];
//    }else{
////        kTipAlert(@"%@", tipStr);
//    }
//}

/**
 *  生成存放十个随机数的数组
 */
+ (NSArray *)RetbackOccasionalNumArr
{
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i ++)
    {
        int m  = arc4random() % 1000;
        [mArr addObject:[NSString stringWithFormat:@"%d",m]];
    }
    return mArr;
}
/**
 *  生成存放随机数的数组
 */
+ (NSArray *)RetbackOccasionalNummerArr:(NSString *)mEndValue
{
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    if ([mEndValue containsString:@"m"])
    {
        int aa = 999/100;
        for (int i = 1; i < aa; i ++)
        {
            int m = i * 100 + arc4random()%100;
            [mArr addObject:[NSString stringWithFormat:@"%d",m]];
        }

        int aaa = [mEndValue intValue]/100;
        for (int i = 1; i < aaa; i ++)
        {
            int m = i * 100 + arc4random()%100;
            [mArr addObject:[NSString stringWithFormat:@"%dk",m]];
        }
        
        NSString *PreStr = [mEndValue substringToIndex:mEndValue.length -1];
        if (mEndValue.length - 1 == 3)
        {
            /**
             *  100m - 999m
             */
            int a = [mEndValue intValue]/100;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 100 + arc4random()%100;
                [mArr addObject:[NSString stringWithFormat:@"%dm",m]];
            }
            [mArr addObject:mEndValue];
        }
        else if (mEndValue.length - 1 == 2)
        {
            /**
             *  10m - 99m
             */
            int a = [PreStr intValue]/10;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 10 + arc4random()%10;
                [mArr addObject:[NSString stringWithFormat:@"%dm",m]];
            }
            [mArr addObject:mEndValue];
        }
        else if (mEndValue.length - 1 == 1)
        {
            /**
             *  1m - 9m
             */
            for (int i = 0; i < [PreStr intValue]; i++)
            {
                [mArr addObject:[NSString stringWithFormat:@"%dm",i]];
            }
            [mArr addObject:mEndValue];
        }
    }
    else if ([mEndValue containsString:@"k"])
    {
        int aa = 999/100;
        for (int i = 1; i < aa; i ++)
        {
            int m = i * 100 + arc4random()%100;
            [mArr addObject:[NSString stringWithFormat:@"%d",m]];
        }
        NSString *PreStr = [mEndValue substringToIndex:mEndValue.length -1];
        /**
         *  以k结尾最大值 1k － 999k
         */
        if (mEndValue.length - 1 == 3)
        {
            /**
             *  100k - 999k
             */
            int a = [mEndValue intValue]/100;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 100 + arc4random()%100;
                [mArr addObject:[NSString stringWithFormat:@"%dk",m]];
            }
            [mArr addObject:mEndValue];
        }
        else if (mEndValue.length - 1 == 2)
        {
            /**
             *  10k - 99k
             */
            /**
             *  只有两位
             */
            int a = [PreStr intValue]/10;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 10 + arc4random()%10;
                [mArr addObject:[NSString stringWithFormat:@"%dk",m]];
            }
            [mArr addObject:mEndValue];
        }
        else if (mEndValue.length - 1 == 1)
        {
            /**
             *  1k - 9k
             */
            for (int i = 0; i < [PreStr intValue]; i++)
            {
                [mArr addObject:[NSString stringWithFormat:@"%dk",i]];
            }
            [mArr addObject:mEndValue];
        }
    }
    else
    {
        /**
         *  常量值  1 - 999
         */
        if (mEndValue.length == 1)
        {
            /**
             *  只有一位
             */
            for (int i = 0; i <= [mEndValue intValue]; i++)
            {
                [mArr addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        else if (mEndValue.length == 2)
        {
            /**
             *  只有两位
             */
            int a = [mEndValue intValue]/10;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 10 + arc4random()%10;
                [mArr addObject:[NSString stringWithFormat:@"%d",m]];
            }
            [mArr addObject:mEndValue];
        }
        else
        {
            /**
             *  只有三位
             */
            int a = [mEndValue intValue]/100;
            for (int i = 1; i < a; i ++)
            {
                int m = i * 100 + arc4random()%100;
                [mArr addObject:[NSString stringWithFormat:@"%d",m]];
            }
            [mArr addObject:mEndValue];
        }
    }
    return mArr;
}
/**
 *  返回没有 .00  后缀的字符串
 */
+ (NSString *)RetBackWithoutZero:(NSString *)mString
{
    NSString *tmpStr = [mString substringWithRange:NSMakeRange(mString.length - 3, 3)];
    if ([tmpStr isEqualToString:@".00"])
    {
        tmpStr = [mString substringWithRange:NSMakeRange(0, mString.length - 3)];
    }
    else
    {
        tmpStr = mString;
    }
    return tmpStr;
}

/**
 *  磁盘总空间
 */
+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
/**
 * 磁盘可用空间大小
 */
+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
/**
 *  获取文件大小
 */
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

/**
 *  获取字符串首字符
 */
+ (NSString *)firstCharacterWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}
////将字符串数组按照元素首字母顺序进行排序分组
//+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array
//{
//    if (array.count == 0) {
//        return nil;
//    }
//    for (id obj in array) {
//        if (![obj isKindOfClass:[NSString class]]) {
//            return nil;
//        }
//    }
//    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
//    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
//    //创建27个分组数组
//    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
//        NSMutableArray *obj = [NSMutableArray array];
//        [objects addObject:obj];
//    }
//    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
//    //按字母顺序进行分组
//    NSInteger lastIndex = -1;
//    for (int i = 0; i < array.count; i++) {
//        NSInteger index = [indexedCollation sectionForObject:array[i] collationStringSelector:@selector(uppercaseString)];
//        [[objects objectAtIndex:index] addObject:array[i]];
//        lastIndex = index;
//    }
//    //去掉空数组
//    for (int i = 0; i < objects.count; i++) {
//        NSMutableArray *obj = objects[i];
//        if (obj.count == 0) {
//            [objects removeObject:obj];
//        }
//    }
//    //获取索引字母
//    for (NSMutableArray *obj in objects)
//    {
//        NSString *str = obj[0];
//        NSString *key = [Utilities firstCharacterWithString:str];
//        [keys addObject:key];
//    }
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:objects forKey:keys];
//    return dic;
//}


#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}
/**
 * 全屏截图
 */
+ (UIImage *)shotScreen
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 * 压缩图片到指定尺寸大小
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size
{
    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return resultImage;
}
/**
 *  字符串中是否有中文
 */
+ (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}
/**
 * 获取UUID
 */
+ (NSString *)getUUID
{
    CFUUIDRef puuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - 私有方法
/**
 *  基本的验证方法
 *
 *  @param regEx 校验格式
 *  @param data  要校验的数据
 *
 *  @return YES:成功 NO:失败
 */
+(BOOL)baseCheckForRegEx:(NSString *)regEx data:(NSString *)data{
    
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    
    if (([card evaluateWithObject:data])) {
        return YES;
    }
    return NO;
}

#pragma mark - 由数字和26个英文字母组成的字符串
+ (BOOL) checkForNumberAndCase:(NSString *)data{
    NSString *regEx = @"^[A-Za-z0-9]+$";
    return [self baseCheckForRegEx:regEx data:data];
}
#pragma mark - 小写字母
+(BOOL)checkForLowerCase:(NSString *)data{
    NSString *regEx = @"^[a-z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

#pragma mark - 大写字母
+(BOOL)checkForUpperCase:(NSString *)data{
    NSString *regEx = @"^[A-Z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}
#pragma mark - 26位英文字母
+(BOOL)checkForLowerAndUpperCase:(NSString *)data{
    NSString *regEx = @"^[A-Za-z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

#pragma mark - 特殊字符
+ (BOOL) checkForSpecialChar:(NSString *)data{
    NSString *regEx = @"[^%&',;=?$\x22]+";
    return [self baseCheckForRegEx:regEx data:data];
}

@end
