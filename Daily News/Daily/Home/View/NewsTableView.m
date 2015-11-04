//
//  NewsTableView.m
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//



#import "NewsTableView.h"
#import "NewsCell.h"
#import "UIViewExt.h"
#import "DayNightManager.h"
#import "AppDelegate.h"
#import "UINavigationBar+Awesome.h"

@implementation NewsTableView

{
    UIImage *_image;
    DayNightManager *_manag;   //主题管家
    CGFloat _alpha ;     //导航栏的颜色透明度

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backcolorNatiAction) name:kthemeName object:nil];
    
    [self _changeNaviColor];
}

-(void)backcolorNatiAction
{
    _manag = [DayNightManager shareInstance];
    
    [UIView animateWithDuration:.1 animations:^{
        
         self.backgroundColor =[_manag getRightColor];
    }];
    
    [self _changeNaviColor];
    [self reloadData];
}

//创建tableView 初始化
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backcolorNatiAction) name:kthemeName object:nil];
            _image = [UIImage imageNamed:@"composeupbg"];
        
        self.showsVerticalScrollIndicator =NO;
        
        self.backgroundColor = [UIColor colorWithWhite:.97 alpha:1];
    }
    return self;
    
}

-(void)setTotalDataArray:(NSMutableArray *)totalDataArray {
    
    if (_totalDataArray != totalDataArray) {
        _totalDataArray = totalDataArray;
        [self reloadData];
    }

}


-(void)setTopData:(NSMutableArray *)topData {
    
    if (_topData != topData) {
        _topData = topData;
        [self reloadData];
    }
}

#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _totalDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = _totalDataArray[section];
    if (section == 0) {
        return array.count + 1;
    }
    else {
        return array.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
        return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    //获取
    Date *time = [[Date alloc] init];
    NSDate *old = [time getOldDateWithDays:section];
    NSArray *nowArray = [time loadDate:old];
    NSString *nowStr = [nowArray lastObject];
    
    //设置头视图的颜色
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    if (_manag.isNight) {
        _label.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    }
    else{
        _label.backgroundColor = [UIColor colorWithRed:50/255.0 green:164/255.0 blue:213/255.0 alpha:1];
    }
    
    //头视图的标题
    _label.text = nowStr;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor whiteColor];

    if (section == 0) {
        _label.text = @"今日热闻";
    }
    
    return _label;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }
    }
    
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier0 = @"header";
    static NSString *identifier = @"NewsCell";
    
    UITableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:identifier0];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //第一个单元格上，滑动视图
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (cell0 == nil) {
                cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
                HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
                
                [cell0.contentView addSubview:headerView];
                headerView.tag = 1;
                
            }

            _headerView = (HeaderView *)[cell0.contentView viewWithTag:1];
            _headerView.topData = self.topData;
            [cell0.contentView addSubview:_headerView];
            
            return  cell0;
            
        }
        
        //其他单元格
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
        }
        NSArray *array = _totalDataArray[indexPath.section];
        
        cell.model = array[indexPath.row-1];
        
        return cell;
 
    }
    else {
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
        }
        NSArray *array = _totalDataArray[indexPath.section];
        
        cell.model = array[indexPath.row];
        
        return cell;
        
    }
    return cell;
    
} 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建新闻详情 viewController
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.dataArray  = [_totalDataArray copy];
    detailVC.indexPath = indexPath;
    
    //第一个单元格点击事件在HeaderView中响应，其他一样
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ;
        }
        
        NSArray *array = _totalDataArray[indexPath.section];
        HomeModel *model = array[indexPath.row - 1];
        detailVC.isHome = YES;
        detailVC.newsId = [model.homeNews_id stringValue];
        
    }
    else {
        NSArray *array = _totalDataArray[indexPath.section];
        HomeModel *model = array[indexPath.row];
        detailVC.isHome = YES;
        detailVC.newsId = [model.homeNews_id stringValue];
        
    }
    
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 滑动tableView事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat y = scrollView.contentOffset.y;
    
    if (y < 0) {
        
        //获取新旧高度
        CGFloat oldHeight = 200;
        CGFloat newHeight = 200 - y;
        
        //放大倍数
        CGFloat scale = newHeight / oldHeight ;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(scale,scale);
        
        _headerView.transform = transform;
        
        //修改中心点
        _headerView.top = y;
        
    }
    
    NSArray *array = _totalDataArray[0];
    CGFloat k = 200;

    //偏移量为一定值时，修改title
    if (y > k + array.count * 70 - 24) {
        
        NSIndexPath *indexPath = [self indexPathForRowAtPoint:CGPointMake(10, y+30)];
        
        Date *time = [[Date alloc] init];
        NSDate *old = [time getOldDateWithDays:indexPath.section];
        
        NSArray *nowArray = [time loadDate:old];
        
        NSString *nowStr = [nowArray lastObject];
        
        self.viewController.title =nowStr;
    }
    //偏移量为 150 － section ＝ 1 之间
    if (150 <= y && y < k + array.count * 70 - 64){

        self.viewController.title = @"今日热闻";
 
    }
    //偏移量在 150 之内
    if (y > 0 && y < 150) {

         self.viewController.title = @"今日热闻";
        
        _alpha = MIN(1, 1 - (( 130 - y) / 130));
        
        [self _changeNaviColor];

    }
    
}

#pragma mark - 修改主题颜色
-(void)_changeNaviColor
{
    if (_manag.isNight) {
        UIColor *color = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
        
        [self.viewController.navigationController.navigationBar lt_setBackgroundColor: [color colorWithAlphaComponent:_alpha]];
    }
    else{
        UIColor *color =[UIColor colorWithRed:50/255.0 green:164/255.0 blue:213/255.0 alpha:1];
        [self.viewController.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:_alpha]];
        
    }

}




@end
