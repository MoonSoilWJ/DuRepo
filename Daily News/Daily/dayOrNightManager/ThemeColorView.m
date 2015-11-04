//
//  ThemeColor.m
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "ThemeColorView.h"
#import "DayNightManager.h"


@implementation ThemeColorView

-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//通过该初始化方法，第一次加载时候就具有 所需要的left颜色
-(instancetype)initWithFrameLeft:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:35/255.0 green:42/255.0 blue:47/255.0 alpha:1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLeftColorNoti) name:kthemeName object:nil];
        
        self.userInteractionEnabled =YES;
    }
    return self;

}

//通过该初始化方法，第一次加载时候就具有 所需要的right颜色

-(instancetype)initWithFrameRight:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor  colorWithWhite:.97 alpha:1];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRightColorNoti) name:kthemeName object:nil];
        
        self.userInteractionEnabled =YES;
    }
    return self;
    
}


//通过该初始化方法，第一次加载时候就具有 所需要的button颜色

-(instancetype)initWithFrameButton:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        self.backgroundColor = [UIColor whiteColor];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getButtonColorNoti) name:kthemeName object:nil];
 
        self.userInteractionEnabled =YES;
        
    }
    return self;
}

//左侧视图接收到改变颜色的通知响应方法
-(void)getLeftColorNoti
{
    DayNightManager *manager = [DayNightManager shareInstance];
    
    [UIView animateWithDuration:.1 animations:^{
        self.backgroundColor = [manager getLeftColor];
    }];
}

//右侧响应方法
-(void)getRightColorNoti
{
    DayNightManager *manager = [DayNightManager shareInstance];
   
    [UIView animateWithDuration:.1 animations:^{
        self.backgroundColor = [manager getRightColor];
    }];
}

//按钮响应方法
-(void)getButtonColorNoti
{
    DayNightManager *manager = [DayNightManager shareInstance];
    
    [UIView animateWithDuration:.1 animations:^{
        self.backgroundColor = [manager getButtonColor];
    }];
}


@end
