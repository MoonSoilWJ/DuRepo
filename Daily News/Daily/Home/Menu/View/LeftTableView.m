//
//  LeftTableView.m
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "LeftTableView.h"
#import "LeftTableViewCell.h"
#import "ThemeColorView.h"
#import "AppDelegate.h"
#import "UIViewExt.h"

@implementation LeftTableView

{
    LeftTableViewCell *_oldCell;
    CGPoint _point;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
   self =  [super initWithFrame:frame style:style];
    if(self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = [UIColor colorWithWhite:.01 alpha:1];
        
    }
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell1= [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell1 == nil) {
        
        cell1 = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    __weak typeof(LeftTableViewCell *)weakCell = cell;
    [cell addBlock:^(){
        
        __strong typeof(LeftTableViewCell *)strongCell = weakCell;
        _point = strongCell.center ;
        
        [self jump];
    }];
 
    if(indexPath.row == 0)
    {
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Menu_Icon_Home@2x"]];
        image.frame = CGRectMake(15, 9, 24, 24);
        [cell1 addSubview:image];
    cell1.textLabel.text = @"        首页";
        cell1.button.selected = YES;
        
        return cell1;
        
    }
    else
    {
     
    cell.model = _data[indexPath.row-1];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count+1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    LeftTableViewCell *newCell = (LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    newCell.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:1];
    newCell.textLabel.textColor = [UIColor whiteColor];
    
    _oldCell.backgroundColor = [UIColor clearColor];
    _oldCell.textLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
    _oldCell = newCell;
    
    
    
    //当点击首页的时候 进入首页， 无id
    if (indexPath.row == 0) {
        
        //关闭右侧视图
        [self.viewController.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
     
        [appdelegate.mmDrawer setCenterViewController:appdelegate.naviVC];
        
    }

    //点击其他cell的时候，根据Id进入VC
    else {
        if (_themeVC == nil) {
            _themeVC = [[ThemeViewController alloc] init];
            
        }
        
        LeftModel *model = _data[indexPath.row-1];
        NSNumber *number = model.titleId;
        _themeVC.themeId = [number stringValue];
        
        _themeVC.title = model.name;
        
        //关闭右侧视图
        [self.viewController.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_themeVC];
        
        
        AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        
        [appdelegate.mmDrawer setCenterViewController:navi];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 42;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


//点击加号的时候，cell跳转到第二个
-(void)jump
{
    NSIndexPath *sourceIndexPath= [self indexPathForRowAtPoint:_point];
    
    CGPoint  point = CGPointMake(10,52) ;// 第二个cell所在的point
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
        
    [UIView animateWithDuration:.8 animations:^{
        
        [self moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
    
    }];
    
    
    //修改改变cell之后的数据
    [_data insertObject:_data[sourceIndexPath.row-1] atIndex:indexPath.row-1];
        
    [_data  removeObjectAtIndex:sourceIndexPath.row];
    
}


@end
