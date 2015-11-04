//
//  NewsTableView.h
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "Common.h"
#import "DetailViewController.h"
#import "UIView+UIViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

@interface NewsTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    
    AFHTTPRequestOperationManager *_manager;
    HeaderView *_headerView;
    Date *_today;
    UILabel *_label;
    
}
@property (nonatomic, strong) NSMutableArray *topData;
@property (nonatomic, strong) NSMutableArray *totalDataArray;   //存放每天的数组

@end
