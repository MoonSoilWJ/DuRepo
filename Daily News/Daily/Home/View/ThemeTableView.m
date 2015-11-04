//
//  ThemeTableView.m
//  Daily
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ThemeTableView.h"


@implementation ThemeTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}

-(void)setThemeId:(NSString *)themeId {
    
    if (themeId != nil) {
        if (_themeId != themeId) {
            _themeId = themeId;
            
            [self loadDataWithThemeId:_themeId];
        }
    }
    
}






-(void)loadDataWithThemeId:(NSString *)themeId {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //url
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",BaseUrl,theme_news,_themeId];
    
    
    
    _dataArray = [NSMutableArray array];
    //send request
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"stories"];
        for (NSDictionary *dic in array) {
            _model = [[ThemeModel alloc] initWithDataDic:dic];
            [_dataArray addObject:_model];
            
        }
        
        [self reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
 
}



#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier0 = @"NoImage";
    static NSString *identifier = @"Image";
    
    ThemeCell *cell0 = [tableView dequeueReusableCellWithIdentifier:identifier0];
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (_model == nil) {
        _model = [[ThemeModel alloc] init];
    }
    _model = _dataArray[indexPath.row];
    //判断是否有图片
    //没有图片
    if (_model.images.count == 0) {
        if (cell0 == nil) {
            cell0 = [[[NSBundle mainBundle] loadNibNamed:@"ThemeCell" owner:self options:nil] firstObject];
        }
        
        cell0.model = _model;
        return cell0;
    }
    
    //有图片
    else {
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThemeCell" owner:self options:nil] lastObject];
        }
        
        cell.model = _model;
        return cell;
    }

    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    ThemeModel *model = _dataArray[indexPath.row];
    
    detailVC.dataArray  = [_dataArray copy];
     detailVC.indexPath = indexPath;

    detailVC.isHome = NO;
    detailVC.newsId = [model.news_id stringValue];
    
   
    
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
    
}


@end
