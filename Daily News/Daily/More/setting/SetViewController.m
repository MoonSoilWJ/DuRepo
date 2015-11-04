//
//  SetViewController.m
//  Daily
//
//  Created by Macx on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SetViewController.h"
#import "ThemeColorView.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "DayNightManager.h"
#import "UIViewExt.h"
#import "ThemeLabel.h"
#import "LogViewController.h"

/*
 设置页面
 */

static NSString *setCellId = @"setCellId";

@interface SetViewController ()
{
    UITableViewCell *_setCell;
    UITableView *_tableView;
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc]initWithFrame:self.navigationController.navigationBar.bounds];
    title.text = @"设置";
    title.textColor = [UIColor whiteColor];
    title.textAlignment =NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:20];
    
    [self.navigationController.navigationBar addSubview:title];
    
    
    [self _createTableView];
    
}

- (void)_createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.showsVerticalScrollIndicator = YES;
    
    [self.view addSubview:_tableView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _setCell= [tableView dequeueReusableCellWithIdentifier:setCellId ];
    
    if (_setCell == nil) {
        _setCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellId];
        _setCell.backgroundColor = [UIColor clearColor];
        ThemeColorView *colorView = [[ThemeColorView alloc]initWithFrameButton:CGRectMake(0, 0, kScreenWidth, 50)];
        [_setCell addSubview:colorView];
    }
    if (indexPath.section == 0) {
        
        ThemeColorView *imageView = [[ThemeColorView alloc]initWithFrameButton:CGRectMake(20, 5, 40, 40)];
        imageView.image = [UIImage imageNamed:@"Account_Avatar@2x"];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        [_setCell addSubview:imageView];
        
        ThemeLabel * textLabel = [[ThemeLabel alloc]initWithFrame:CGRectMake(80, 5, 200, 40)];
        textLabel.text = @"我的资料";
        [_setCell addSubview:textLabel];
        _setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1){
        
        ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
        label.text =@"自动离线下载";
        [_setCell addSubview:label];
        
    }else if(indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text =@"移动网络不下载图片";
            [_setCell addSubview:label];
            
        }else if(indexPath.row == 1){
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text = @"大字号";
            [_setCell addSubview:label];
        }
    }else if(indexPath.section == 3){
        
        if (indexPath.row == 0) {
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text = @"消息推送";
            
            [_setCell addSubview:label];
            
        }else if(indexPath.row == 1){
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text = @"点评分享到微博";
            [_setCell addSubview:label];
        }
    }else if(indexPath.section == 4){
        
        if (indexPath.row == 0) {
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text = @"去好评";
            [_setCell addSubview:label];
            _setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if(indexPath.row == 1){
            
            ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
            label.text = @"去吐槽";
            [_setCell addSubview:label];
            _setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if(indexPath.section == 5){
        
        ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth, 40)];
        label.text = @"清除缓存";
        [_setCell addSubview:label];
    }
    
    
    return _setCell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row;
    switch (section) {
        case 0:
            return row = 1;
            break;
        case 1:
            return row = 1;
            break;
            
        case 2:
            return row = 2;
            break;
            
        case 3:
            return row = 2;
            break;
            
        case 4:
            return row = 2;
            break;
            
        case 5:
            return row = 1;
            break;
            
        default:
            break;
    }
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        LogViewController *log = [[LogViewController alloc]init];
        log.tag = @"set";
        
        [self.navigationController pushViewController:log animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
