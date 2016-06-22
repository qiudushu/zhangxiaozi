//
//  MainViewController.m
//  张亚姿
//
//  Created by 邱读书 on 16/5/19.
//  Copyright © 2016年 邱读书. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"
#import <Masonry.h>

@interface MainViewController ()

@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    
    for (int i = 0 ; i < 10; i ++)
    {
        NSLog(@"-------%d",i);
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"=======%d",i);
        });
    }
    
    NSNumber *mN = [NSNumber numberWithFloat:33.6677];
    NSLog(@"=====%@",mN);
    
    UILabel *mAAA = [[UILabel alloc]init];
    mAAA.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:mAAA];
    
    [mAAA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(100);
        make.top.equalTo(self.view.mas_top).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
    /**
     *  生成随机数
     */
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    int m  = arc4random() % 2000;
    [mArr addObject:[NSString stringWithFormat:@"%d",m]];
    
    /**
     *  随机数
     */
    NSArray *mNumArr = [MyHelper RetbackOccasionalNummerArr:@"9"];
    NSLog(@"随机数=======>%@",mNumArr);
    NSArray *mNumArr1 = [MyHelper RetbackOccasionalNummerArr:@"98"];
    NSLog(@"随机数1=======>%@",mNumArr1);
    NSArray *mNumArr2 = [MyHelper RetbackOccasionalNummerArr:@"798"];
    NSLog(@"随机数2=======>%@",mNumArr2);
    
    /**
     *  1k - 9k
     */
    
    NSArray *mNumArr3 = [MyHelper RetbackOccasionalNummerArr:@"7k"];
    NSLog(@"随机数3=======>%@",mNumArr3);
    /**
     *  10k - 99k
     */
    
    NSArray *mNumArr4 = [MyHelper RetbackOccasionalNummerArr:@"86k"];
    NSLog(@"随机数4=======>%@",mNumArr4);
    /**
     *  100k - 999k
     */
    
    NSArray *mNumArr5 = [MyHelper RetbackOccasionalNummerArr:@"686k"];
    NSLog(@"随机数5=======>%@",mNumArr5);
    
    /**
     *  1m - 10m
     */
    
    NSArray *mNumArr6 = [MyHelper RetbackOccasionalNummerArr:@"3m"];
    NSLog(@"随机数6=======>%@",mNumArr6);

    /**
     *  10m - 99m
     */
    
    NSArray *mNumArr7 = [MyHelper RetbackOccasionalNummerArr:@"68m"];
    NSLog(@"随机数7=======>%@",mNumArr7);
    /**
     *  100m - 999m
     */
    
    NSArray *mNumArr8 = [MyHelper RetbackOccasionalNummerArr:@"686m"];
    NSLog(@"随机数8=======>%@",mNumArr8);
    
    NSLog(@"单例＝＝＝%@",[MyHelper ShareMyHelper].qiudushu);
    
    [MyHelper ShareMyHelper].qiudushu = @"张亚姿";
    

}
- (IBAction)buttonAction:(id)sender
{
    WebViewController *mWeb = [[WebViewController alloc]init];
    [self.navigationController pushViewController:mWeb animated:YES];
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
