//
//  BaseTabbarViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "ForthViewController.h"
#import "AnimalViewController.h"


@interface BaseTabbarViewController ()
{
    AnimalViewController *aniVc;
    UIButton *btn_animal;
}
@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  设置主控制器
     */
    [self setUpAllChildViewController];
}
/**
 *  改变选中的状态
 */
//- (void)changeStatus:(id )sender
//{
//    //添加放大效果
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    NSMutableArray *values = [NSMutableArray new];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [btn_animal.layer addAnimation:animation forKey:nil];
//    
//    aniVc  = [[AnimalViewController alloc]init];
//    //    [self setUpOneChildViewController:aniVc image:[UIImage imageNamed:@"btn_Tabbar_Community"] selectedImage:[UIImage imageNamed:@"btn_Tabbar_Community_on"] title:@"美美"];
//    [self setUpOneChildViewController:aniVc image:nil selectedImage:nil title:@"美美"];
//
//}
/**
 *  添加所有子控制器方法
 */
- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    FirstViewController *oneVC = [[FirstViewController alloc]init];
    [self setUpOneChildViewController:oneVC image:@"btn_tabbar_home" selectedImage:@"btn_tabbar_home_on" title:@"首页"];
    
    // 2.添加第2个控制器
    SecondViewController *twoVC = [[SecondViewController alloc]init];
    [self setUpOneChildViewController:twoVC image:@"btn_tabbar_shoppingbuy" selectedImage:@"btn_tabbar_shoppingbuy_on" title:@"技术"];
    
    ////////
    aniVc  = [[AnimalViewController alloc]init];
    [self setUpOneChildViewController:aniVc image:@"btn_Tabbar_Community" selectedImage:@"btn_Tabbar_Community_on" title:@"美美"];
    
    // 3.添加第3个控制器
    ThreeViewController *threeVC = [[ThreeViewController alloc]init];
    [self setUpOneChildViewController:threeVC image:@"btn_tabbar_shoppingcart"selectedImage:@"btn_tabbar_shoppingcart_on" title:@"博文"];
    
    // 4.添加第4个控制器
    ForthViewController *fourVC = [[ForthViewController alloc]init];
    [self setUpOneChildViewController:fourVC image:@"btn_tabbar_myPanli" selectedImage:@"btn_tabbar_myPanli_on" title:@"闺房"];
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
