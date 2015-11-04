//
//  MessageViewController.m
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//
/*
 消息
 */
#import "MessageViewController.h"

@interface MessageViewController ()


@end
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UILabel *title = [[UILabel alloc]initWithFrame:self.navigationController.navigationBar.bounds];
    title.text = @"消息";
    title.textColor = [UIColor whiteColor];
    title.textAlignment =NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:20];
    [self.navigationController.navigationBar addSubview:title];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
