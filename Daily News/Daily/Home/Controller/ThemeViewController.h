//
//  ThemeViewController.h
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeTableView.h"
#import "UIViewController+MMDrawerController.h"


@interface ThemeViewController : BaseViewController

@property (nonatomic, strong) NSString *themeId ;
@property (nonatomic, strong) ThemeTableView *tableView ;





@end
