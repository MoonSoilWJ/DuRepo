//
//  HeardView.m
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HeaderView.h"
#import "Common.h"
#import "TopModel.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

@interface HeaderView ()<UIScrollViewDelegate>
{
    NSInteger _count;
    CGFloat _width;
    UIPageControl *_page;
    NSTimer *_timer;
    
}


@end

@implementation HeaderView


-(void)setTopData:(NSArray *)topData {
    
    if (_topData != topData) {
        _topData = topData;
        _count = topData.count;
        _width = 200;
        [self createScrollView];
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    
    
}

//循环切换新闻
-(void)timerAction:(NSTimer *)timer {
    
    static NSInteger m = 0;
    _page.currentPage = m;
    m++;
    [self pageValueChange];
    if (m == 5) {
        m = 0;
    } 
}


-(void)createScrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
    }
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _count, _width);
    _scrollView.showsHorizontalScrollIndicator = NO;

    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    for (NSInteger i = 0; i < _count; i++) {
        
        //01 获取新闻model
        TopModel *model = _topData[i];
        
        //02 创建背景图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, _width)];
        NSString *urlStr = model.image;
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:imageView];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        
        
        //03 创建遮罩视图
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, _width - 150, kScreenWidth, 150)];
        backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_Image_Mask@2x"]];
        [imageView addSubview:backView];
        
        //04 创建label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth - 10 - 10, 60)];
        label.text = model.title;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        [imageView addSubview:label];
        
    }
    
    [self addSubview:_scrollView];
    
    //05 创建pageControl
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _width - 30, kScreenWidth, 30)];
    _page.numberOfPages = _count;
    _page.currentPage = 0;
    [_page addTarget:self action:@selector(pageValueChange) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_page];
    
    
    //        //给每个图片加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    
}


-(void)tapAction:(UITapGestureRecognizer *)tap {
    NSInteger index = _page.currentPage;
    TopModel *model = _topData[index];
//    NSLog(@"%@",model);
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.isHome = YES;
    detailVC.newsId = [model.top_id stringValue];

    [self.viewController.navigationController pushViewController:detailVC animated:YES];

    
}

#pragma mark - 结束滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //偏移量
    CGFloat offX = _scrollView.contentOffset.x;
    NSInteger index = offX / kScreenWidth;
    _page.currentPage = index;
    
}


#pragma mark - page value 改变
-(void)pageValueChange {
    
    NSInteger index = _page.currentPage;
    CGFloat offX = index * kScreenWidth;
    CGPoint off = CGPointMake(offX, 0);
    [_scrollView setContentOffset:off animated:YES];
    
}




@end
