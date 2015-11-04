//
//  HomeViewController.m
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "Common.h"
#import "TopModel.h"
#import "HomeModel.h"
#import "DayNightManager.h"
#import "ThemeColorView.h"
#import "UINavigationBar+Awesome.h"

@interface HomeViewController ()
{
    NSMutableArray *_dataArray;
    
    NSMutableArray *_topArray;
    AFHTTPRequestOperationManager *_manager;
    Date *_dateToday;
    
    NSMutableArray *_totalDataArray;
    NSMutableArray *_sectionModelArray ;

    CGFloat _yOff;
        UIImage *_image;
     NewsTableView *_tableView;

}
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated {
    //状态栏白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    _totalDataArray = [[NSMutableArray alloc] init];
    
    self.view = [[ThemeColorView alloc]initWithFrameRight:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [self setNavi];
    [self loadData];
    [self createViews];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

}



#pragma mark - 导航栏
-(void)setNavi {
    //导航栏字体
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                 };
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //背景图片 －－－初始为空
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    //菜单按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [button setImage:[UIImage imageNamed:@"Home_Icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menu;
    
}

#pragma mark - leftView
-(void)menuAction:(UIButton *)button {
    
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}


#pragma mark - tableview
-(void)createViews {
    self.title = @"今日热闻";
    //创建tableview
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];

    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    //MJfresh的三方库的使用
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:_tableView];

}

#pragma mark - 下拉加载更多
-(void)loadMoreData {
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _dateToday = [[Date alloc] init];
    }
    static NSInteger index = 0;
    
    //获取历史日期的字符串
    NSDate *sectionDate = [_dateToday getOldDateWithDays:index];
    NSArray *secArray = [_dateToday loadDate:sectionDate];
    NSString *secStr = [secArray firstObject];
    
    _sectionModelArray = [[NSMutableArray alloc] init];
    
    //拼接URL
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",BaseUrl,news_history,secStr];

    NSDictionary *params = @{
                             @"format" : @"json",
                             };

    [_manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //获取新闻
        NSArray *stories = [responseObject valueForKey:@"stories"];
        
        for (NSDictionary *hot in stories) {
            HomeModel *model = [[HomeModel alloc] initWithDataDic:hot];
            [_sectionModelArray addObject:model];
        }
        
        [_totalDataArray addObject:_sectionModelArray];
        
        _tableView.totalDataArray = _totalDataArray;
        
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"失败%@",error);
    }];
    
    index ++;

    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark - 加载数据
-(void)loadData {
    
//    NSLog(@"loadData");
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl,news_latest];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{
                             @"format" : @"json",
                             };

    _dataArray = [NSMutableArray array];
    _topArray = [NSMutableArray array];
    
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求首页新闻成功");
        //top新闻
        NSArray *top = [responseObject valueForKey:@"top_stories"];
        for (NSDictionary *dic in top) {
            TopModel *model = [[TopModel alloc] initWithDataDic:dic];
            [_topArray addObject:model];
        }
        _tableView.topData = _topArray;
        
        //首页新闻
        NSArray *recent = [responseObject valueForKey:@"stories"];
        for (NSDictionary *hot in recent) {
            HomeModel *model = [[HomeModel alloc] initWithDataDic:hot];
            [_dataArray addObject:model];
        }
        
        if (_totalDataArray.count > 0) {
            [_totalDataArray removeObjectAtIndex:0];
            
            
            //只有一个元素的时候，（只有今天的新闻）
            if (_totalDataArray.count == 0) {
                [_totalDataArray addObject:_dataArray];
                
                
            }else {
                //多个元素
                NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:_totalDataArray.count+1];
                for (int i = 0; i < _totalDataArray.count + 1; i++) {
                    if (i == 0) {
                        [newArray addObject:_dataArray];
                    }else {
                        [newArray addObject:_totalDataArray[i-1]];
                    }
                    
                }
                _totalDataArray = newArray;
                
            }
            
        }else {
            [_totalDataArray addObject:_dataArray];
        }
        _tableView.totalDataArray = _totalDataArray;
        
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"请求首页新闻失败%@",error);
    }];
    
    _tableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
