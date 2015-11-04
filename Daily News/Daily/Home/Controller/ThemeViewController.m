//
//  ThemeViewController.m
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

-(void)setThemeId:(NSString *)themeId {
    if (_themeId != themeId) {
        _themeId = themeId;
        
        /*因为各个主题的新闻列表使用的是同一个viewcontroller 
         每次加载id的时候，删除上一个主题列表，
         并重新创建一个主题列表*/
        [_tableView removeFromSuperview];
        [self createTableView];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavi];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated
{

    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                 
                                 };
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
}

-(void)createNavi {

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"Back@2x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menu;
    
}

-(void)backAction:(UIButton *)button {
    
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

-(void)createTableView {
    
    _tableView = [[ThemeTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.themeId = _themeId;
    
    
    [self.view addSubview:_tableView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
