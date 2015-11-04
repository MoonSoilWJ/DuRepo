//
//  ThemeTableView.h
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
#import "AFNetworking.h"
#import "Common.h"
#import "ThemeCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "UIView+UIViewController.h"

@interface ThemeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ThemeModel *model;
@property (nonatomic, copy) NSString *themeId;

@property (nonatomic, strong) NSMutableArray *dataArray;




@end
