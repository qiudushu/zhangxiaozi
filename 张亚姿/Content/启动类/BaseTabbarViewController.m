//
//  BaseTabbarViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "MainViewController.h"
#import "PractiseViewController.h"
#import "TeachViewController.h"
#import "MineViewController.h"

@interface BaseTabbarViewController ()
{
    UIButton *btn_animal;
}
@end

@implementation BaseTabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  设置主控制器
     */
    [self setUpAllChildViewController];
}
/**
 *  添加所有子控制器方法
 */
- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    MainViewController *oneVC = [[MainViewController alloc]init];
    [self setUpOneChildViewController:oneVC image:@"btn_tabbar_home" selectedImage:@"btn_tabbar_home_on" title:@"首页"];
    
    // 2.添加第2个控制器
    PractiseViewController *twoVC = [[PractiseViewController alloc]init];
    [self setUpOneChildViewController:twoVC image:@"btn_tabbar_shoppingbuy" selectedImage:@"btn_tabbar_shoppingbuy_on" title:@"练习"];
    
    ////////
    TeachViewController *teachVC = [[TeachViewController alloc]init];
    [self setUpOneChildViewController:teachVC image:@"btn_tabbar_shoppingbuy" selectedImage:@"btn_tabbar_shoppingbuy_on" title:@"技术"];
    
    // 3.添加第3个控制器
    MineViewController *threeVC = [[MineViewController alloc]init];
    [self setUpOneChildViewController:threeVC image:@"btn_tabbar_shoppingcart"selectedImage:@"btn_tabbar_shoppingcart_on" title:@"闺房"];
}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(NSString *)image  selectedImage:(NSString *)selectedImage title:(NSString *)title{
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.navigationBar.translucent = NO;
    
    viewController.navigationItem.title = title;
    [navC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [self addChildViewController:navC];
}
@end
