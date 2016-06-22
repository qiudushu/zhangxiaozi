//
//  TeachViewController.m
//  张亚姿
//
//  Created by 邱读书 on 16/5/19.
//  Copyright © 2016年 邱读书. All rights reserved.
//

#import "TeachViewController.h"
#import "ZFProgressView.h"
#import "LBToAppStore.h"


@interface TeachViewController ()

@end

@implementation TeachViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ZFProgressView *progress1 = [[ZFProgressView alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    [self.view addSubview:progress1];
    [progress1 setProgress:0.6 Animated:YES EndValue:@"100k"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //用户好评系统
    LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
    toAppStore.myAppID = @"797395756";//@"1067787090";
    [toAppStore showGotoAppStore:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
