//
//  BaseViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 * 功能描述: 重写viewdidload
 * 输入参数: backButton 是否需要左边返回按钮
 * 返 回 值: N/A
 */
- (void)viewDidLoadWithBackButtom:(BOOL)backButton
{
    [super viewDidLoad];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarButtonItem:backButton];
}
- (void)setBarButtonItem:(BOOL)isBack
{
    //是否显示返回按钮
    if (isBack)
    {
        UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 54.0f, 44.0f);
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
        btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -34, 0, 0) : UIEdgeInsetsZero;
        [btn_nav_back addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
        self.navigationItem.leftBarButtonItem = btn_Left;
    }
    else
    {
        [self.navigationItem setHidesBackButton:YES];
    }
}
- (void)barButtonItemClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
