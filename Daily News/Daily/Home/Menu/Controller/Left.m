//
//  Left.m
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "Left.h"
#import "LeftTableView.h"
#import "TouchView.h"
#import "MessageViewController.h"
#import "ThemeColorView.h"
#import "ThemeImageView.h"
#import "AFNetworking.h"
#import "LeftModel.h"
#import "DayNightManager.h"
#import "LogViewController.h"
#import "AppDelegate.h"
#import "SetViewController.h"

@interface Left ()
{
    LeftTableView *_tableView;
 
}
@end

@implementation Left

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTouchView];
    
    self.view.frame = CGRectMake(0, 0, 260, kScreenHeight);
    ThemeColorView *backgroundView =[[ThemeColorView alloc]initWithFrameLeft:self.view.bounds];
    
    [self.view addSubview:backgroundView];
    [self _loadData];
    [self _createSubViews];//创建上、中、下 3个子视图

}

#pragma mark 网络获取信息
-(void)_loadData
{
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = @{@"format": @"json"};
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl,list];
    
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation ,id responseObject){
        
//        NSLog(@"主题列表加载成功");
        NSArray *othersArray = [responseObject objectForKey:@"others"];
        
        NSMutableArray *modelsArray = [[NSMutableArray alloc]initWithCapacity:othersArray.count];
        for(NSDictionary *dic in othersArray)
        {
            LeftModel *model = [[LeftModel alloc]initWithDataDic:dic];
            [modelsArray addObject:model];
        }
        
        _tableView.data = modelsArray;
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation ,NSError *error){
//        NSLog(@"主题列表加载失败");
    }];
}
-(void)_createSubViews
{
    //1.创建topView
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 140)];
    topView.userInteractionEnabled =YES;
    topView.backgroundColor = [UIColor clearColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 260, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    [topView addSubview:lineView];

    [self.view addSubview:topView];
    
    //添加topView的button
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 100, 40)];
    UIImage *image = [UIImage imageNamed:@"Account_Avatar@2x"];
   
    //button的imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds = YES;
    imageView.image = image;
    [loginButton addSubview:imageView];
    //button的label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 60, 20)];
    label.text = @"请登录";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithWhite:.5 alpha:1];
    [loginButton addSubview:label];
    
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    //收藏，消息，设置按钮
    NSArray *imagesArray = @[@"Menu_Icon_Collect@2x",
                             @"Menu_Icon_Message@2x",
                             @"Menu_Icon_Setting@2x"
                             ];
    NSArray *titleArray = @[
                            @"收藏",
                            @"消息",
                            @"设置"
                            ];
    CGFloat buttonWidth = 240/3.0;
    for(int i = 0;i < 3;i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 50, 100, 80)];
        
        [button setImage:[UIImage imageNamed:imagesArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        //给title一个偏移量，使其移到图片下方
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -45, 45)];
        [button setTitleColor:[UIColor colorWithWhite:.5 alpha:1] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:)forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [topView addSubview:button];
    }
    
    [topView addSubview:loginButton];
    
    //2.创建中间的tableView视图
    _tableView = [[LeftTableView alloc] initWithFrame:CGRectMake(0, 140,260 , kScreenHeight-64-135) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];

    //3.创建下面的视图
    ThemeImageView *bottomView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight-64, 260, 64)];
    bottomView.userInteractionEnabled = YES;
    bottomView.imageName = @"Menu_Mask@2x";
    bottomView.contentMode = UIViewContentModeBottom;
    
    //download Button
    UIButton *downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 64, 24)];
    //button 的imageview
    UIImageView *downOffView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    downOffView.image = [UIImage imageNamed:@"Menu_Download@2x"];
    [downloadButton addSubview:downOffView];
    //button 的 label
    UILabel *downOffLabel = [[UILabel alloc] initWithFrame:CGRectMake(45 , 0, 60, 24)];
    downOffLabel.text = @"离线";
    downOffLabel.textAlignment = NSTextAlignmentLeft;
    downOffLabel.font = [UIFont systemFontOfSize:14];
    downOffLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
    
    [downloadButton addSubview:downOffLabel];
    [downloadButton addTarget:self action:@selector(downloadOff) forControlEvents:UIControlEventTouchUpInside];
    
    
    //改变主题 的button
    UIButton *changeThemeButton = [[UIButton alloc] initWithFrame:CGRectMake(145, 20, 100, 24)];

    //button 的 图片
    [changeThemeButton setImage:[UIImage imageNamed:@"Menu_Dark@2x"] forState:UIControlStateNormal];
    [changeThemeButton setImage:[UIImage imageNamed:@"Menu_Day@2x"] forState:UIControlStateSelected];
    
    //button 的 title
    changeThemeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [changeThemeButton setTitle:@"夜间" forState:UIControlStateNormal];
    [changeThemeButton setTitleColor:[UIColor colorWithWhite:.5 alpha:1] forState:UIControlStateNormal];
    [changeThemeButton setTitle:@"白天" forState:UIControlStateSelected];
    [changeThemeButton setTitleColor:[UIColor colorWithWhite:.5 alpha:1] forState:UIControlStateSelected];
    [changeThemeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];

    [changeThemeButton addTarget:self action:@selector(changeDayNight:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:downloadButton];
    [bottomView addSubview:changeThemeButton];

    [self.view addSubview:bottomView];
    
}


#pragma mark 登录按钮 进入页面
-(void)loginAction
{
    LogViewController *loginVC = [[LogViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark 三个按钮的响应方法
-(void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            [self loginAction];
            break;
        case 1:
            [self messageAction];
            break;
        case 2:
            [self setAction];
            break;
            
        default:
            break;
    }
    
}

//消息
-(void)messageAction {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    
    BaseNavigationViewController *naviVC = [[BaseNavigationViewController alloc]initWithRootViewController:messageVC];
    [appdelegate.mmDrawer setCenterViewController:naviVC];

}

//设置
-(void)setAction {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    SetViewController *messageVC = [[SetViewController alloc]init];
    
    BaseNavigationViewController *naviVC = [[BaseNavigationViewController alloc]initWithRootViewController:messageVC];
    [appdelegate.mmDrawer setCenterViewController:naviVC];
}

#pragma mark 离线下载按钮 开始下载
-(void)downloadOff
{
    NSLog(@"开始离线下载");
}

#pragma mark 更改白天黑夜的皮肤
-(void)changeDayNight:(UIButton *)button
{
    DayNightManager *manager = [DayNightManager shareInstance];
    
    manager.isNight = !manager.isNight;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kthemeName object:nil];
   
    button.selected = !button.selected;
}


-(void)_createTouchView
{
    TouchView *touchView = [[TouchView alloc]initWithFrame:self.view.bounds];
    self.view  = touchView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
