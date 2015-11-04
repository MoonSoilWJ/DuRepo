//
//  FirstViewController.m
//  Zhihu Daily
//
//  Created by Macx on 15/10/27.
//  Copyright (c) 2015年 HeminWon. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "FirstViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createScrollView];
    
   
    
}

//创建存放大图的scrollview
- (void)_createScrollView{
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_scrollView];
    
    // 内容视图
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollView.frame];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(-kScreenWidth/2,kScreenHeight-293, 2*kScreenWidth, 300)];

    
    imageView.image = [UIImage imageNamed:@"Splash_Image@2x.jpg"];
    imageView2.image = [UIImage imageNamed:@"Splash_Logo_Plus@2x"];
    
    imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

    

    
    
    
    [_scrollView addSubview:imageView];
    [self.view addSubview:imageView2];
    
    
    
    [UIView animateWithDuration:2.0 animations:^{
        imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    }completion:^(BOOL finished){
        
        [self jumpToHome]; //进入home主页
    }];
}

//启动画面加载结束后进入home主页
-(void)jumpToHome
{
    
    //将是否是第一次启动保存到userdefaults中
    [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"First"];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
    self.view.window.rootViewController = appdelegate.mmDrawer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
