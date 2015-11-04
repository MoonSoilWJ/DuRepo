//
//  ThemeNaviC.m
//  Daily
//
//  Created by MAC19 on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ThemeVC.h"
#import "DayNightManager.h"
#import "ThemeColorView.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface ThemeVC ()

@end

@implementation ThemeVC

/*此控制器的navigationBar颜色白天为蓝色，晚上为黑色。
 在本类中已经封装颜色改变的方法，其他viewController可以继承本类避免代码重复编写
*/

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self _createNaviItem];

    //self.view 通过 themeColorView 创建，方便更改颜色
    self.view = [[ThemeColorView alloc] initWithFrameRight:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50/255.0 green:164/255.0 blue:213/255.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageColorNatiAction) name:kthemeName object:nil];
    
    
    
}

-(void)imageColorNatiAction
{
    DayNightManager *manager = [DayNightManager shareInstance];
    
    
    if (manager.isNight) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    }
    else
    {
        [UIView animateWithDuration:.0 animations:^{
            
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50/255.0 green:164/255.0 blue:213/255.0 alpha:1];
        }];
    }
}


-(void)_createNaviItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 2, 42, 42)];
    
    UIImage *imageN = [UIImage imageNamed:@"Back_White@2x"];
    [button setImage:imageN forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
}

//点击按钮弹出左侧视图
-(void)menuAction:(UIButton *)button {
    
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
