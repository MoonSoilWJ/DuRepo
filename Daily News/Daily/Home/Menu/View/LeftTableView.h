//
//  LeftTableView.h
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"
#import "UIView+UIViewController.h"
#import "ThemeViewController.h"

@interface LeftTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ThemeViewController *themeVC;
@property(nonatomic,strong)NSMutableArray *data;

@end
