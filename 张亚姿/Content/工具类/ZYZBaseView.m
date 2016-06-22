//
//  ZYZBaseView.m
//  张亚姿
//
//  Created by 邱读书 on 16/6/11.
//  Copyright © 2016年 邱读书. All rights reserved.
//

#import "ZYZBaseView.h"

@implementation ZYZBaseView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self CreateBtn];
    }
    return self;
}

- (void)CreateBtn
{
    ZYZbaseButton *mBtn = [[ZYZbaseButton alloc]init];
    [mBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [mBtn setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:mBtn];
    [mBtn addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ButtonAction:(ZYZbaseButton *)mSender
{
}
@end
