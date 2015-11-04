//
//  LogViewController.m
//  知乎日报
//
//  Created by MAC19 on 15/10/26.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

/*
 登录页面
 
 */

#import "LogViewController.h"
#import "SetViewController.h"
#import "Left.h"
#import "SetViewController.h"
#import "BaseNavigationViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Login_Background@2x"];
    self.view.layer.contents = (__bridge id)(image.CGImage);
    self.view.contentMode = UIViewContentModeScaleToFill;
    

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self _createNaviItem];
    
    [self _createSubView];
}

-(void)_createNaviItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 2, 42, 42)];
    UIImage *imageH =[UIImage imageNamed:@"Login_Arrow_Highlight@2x"] ;

    [button setImage:imageH forState:UIControlStateHighlighted];
    UIImage *imageN = [UIImage imageNamed:@"Login_Arrow@2x"];
    [button setImage:imageN forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

-(void)back
{
    if ([self.tag isEqualToString:@"set"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)_createSubView
{
    //logo视图
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 80, 135, 45)];
    logoView.image = [UIImage imageNamed:@"Login_Logo@2x"];
    
    [self.view addSubview:logoView];
    
    //登录label
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(125, 300, 125, 20)];
    label.text  = @"使用微博登录";
    label.textColor = [UIColor colorWithWhite:.9 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    //新浪登录
    
    UIButton *sinaButton = [[UIButton alloc]initWithFrame:CGRectMake(62, 350, 260, 51)];
    [sinaButton setImage:[UIImage imageNamed:@"Login_Button_Sina_Highlight@2x"] forState:UIControlStateHighlighted];
    
    [sinaButton setImage:[UIImage imageNamed:@"Login_Button_Sina@2x"] forState:UIControlStateNormal];
    
    [sinaButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    sinaButton.tag = 0;
    
    UILabel *sinaLabel = [[UILabel alloc]initWithFrame:sinaButton.bounds];
    sinaLabel.text = @"新浪微博";
    sinaLabel.textAlignment = NSTextAlignmentCenter;
    [sinaButton addSubview:sinaLabel];
    
    [self.view addSubview:sinaButton];
    
    
    //腾讯登录
    UIButton *tenButton = [[UIButton alloc]initWithFrame:CGRectMake(62, 430, 260, 51)];
    [tenButton setImage:[UIImage imageNamed:@"Login_Button_Tencent_Highlight@2x"] forState:UIControlStateHighlighted];
    
    [tenButton setImage:[UIImage imageNamed:@"Login_Button_Tencent@2x"] forState:UIControlStateNormal];
    
    [tenButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    tenButton.tag = 1;
    
    UILabel *tenLabel = [[UILabel alloc]initWithFrame:sinaButton.bounds];
    tenLabel.text = @"腾讯微博";
    tenLabel.textAlignment = NSTextAlignmentCenter;
    [tenButton addSubview:tenLabel];
    
    [self.view addSubview:tenButton];
    
    
    //提示label
    UILabel *remand = [[UILabel alloc]initWithFrame:CGRectMake(0,kScreenHeight-60-64, kScreenWidth, 60)];
    remand.textAlignment = NSTextAlignmentCenter;
    remand.text = @"知乎日报不会未经同意通过你的微博发送任何信息";
    remand.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:remand];
}

-(void)login:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"新浪微博Login");
    }
    else
    {
        NSLog(@"腾讯微博Login");
    }
}

@end
