//
//  GuideViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "GuideViewController.h"
#import "BaseTabbarViewController.h"
#import "AppDelegate.h"
#import "HADirect.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /**
     *  引导页
     *
     *  @return <#return value description#>
     */
    HADirect *d = [HADirect direcWithtFrame:kFrame ImageArr:@[@"user_1.jpg",@"user_2.jpg",@"user_3.jpg",@"user_4.jpg"] AndImageClickBlock:^(NSInteger index) {
        NSLog(@"点击的是当前  %ld  张照片 ",(long)index);
    }];
//    [d stopTimer];
    [self.view addSubview:d];
    
    UIButton *mBtn = [[UIButton alloc]init];
    mBtn.frame = CGRectMake(0, 40, 200, 40);
    mBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [mBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [mBtn addTarget:self action:@selector(GuideEndAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GuideEndAction
{
    BaseTabbarViewController *tabBarController = [[BaseTabbarViewController alloc] init];
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = tabBarController;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [userDefaults setObject:version forKey:@"ISFIRSTOPEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self prefersStatusBarHidden];

}


@end
