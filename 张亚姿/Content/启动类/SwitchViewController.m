//
//  SwitchViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "SwitchViewController.h"
#import "GuideViewController.h"
#import "BaseTabbarViewController.h"
#import "AppDelegate.h"

#define IMGURL @"http://b.hiphotos.baidu.com/image/pic/item/faf2b2119313b07e73cdc2690ad7912397dd8c5b.jpg"

@interface SwitchViewController ()
{
    NSTimer *switchTimer;
    float seconds;
    UIImageView  *imageLaunch;
}
@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //计时器
    switchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(timerAction:)
                                                 userInfo:nil
                                                  repeats:YES];
    
    imageLaunch = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    if ([MyHelper connectedToNetwork])
//    {
//        [imageLaunch sd_setImageWithURL:[NSURL URLWithString:IMGURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (error)
//            {
//                imageLaunch.image = [UIImage imageNamed:@"Launch-h568@2x.png"];
//            }
//            else
//            {
//                imageLaunch.image = image;
//            }
//        }];
//        
////        [imageLaunch sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",IMGURL]]];
//    }
//    else
//    {
//        imageLaunch.image = [UIImage imageNamed:@"Launch-h568@2x.png"];
//    }
//    [self.view addSubview:imageLaunch];
    
    imageLaunch.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageLaunch];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = imageLaunch.center;
    [activityIndicatorView startAnimating];
    [self.view addSubview:activityIndicatorView];
    
    
    UIButton *mBtn = [[UIButton alloc]init];
    mBtn.frame = CGRectMake(0, kHeight - 40, kWidth, 40);
    [mBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [mBtn addTarget:self action:@selector(swithRootView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
}

- (void)timerAction:(NSTimer *)timer
{
    seconds+=1;
    //请求完成且时间超过6秒
    if (seconds >= 10)
    {
        [switchTimer invalidate];
        switchTimer = nil;
        [self swithRootView];
    }
}
- (void)swithRootView
{
    [switchTimer invalidate];
    switchTimer = nil;
    /**
     *  第一次进入  就引导页
     *
     *  非第一次进入就tabbaer
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *firstFlag = [userDefaults objectForKey:@"ISFIRSTOPEN"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //判断是否是第一次打开程序
    if ([firstFlag isEqualToString:version])
    {
        BaseTabbarViewController *tabBarController = [[BaseTabbarViewController alloc] init];
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = tabBarController;
    }
    else
    {
        // 负责呈现新手引导画面
        GuideViewController *guideViewController = [[GuideViewController alloc]init];
        //        guideViewController.fromPageType = 0;
        ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = guideViewController;
    }

}
@end
