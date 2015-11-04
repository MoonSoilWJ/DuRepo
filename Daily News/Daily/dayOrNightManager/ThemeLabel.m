//
//  ThemeLabel.m
//  知乎日报
//
//  Created by MAC19 on 15/10/26.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "ThemeLabel.h"
#import "DayNightManager.h"

@implementation ThemeLabel


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(labelNotiAction) name:kthemeName object:nil];
    }
    
    return self;
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.textColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(labelNotiAction) name:kthemeName object:nil];
}

-(void)labelNotiAction
{
    DayNightManager *manager =[DayNightManager shareInstance];
    
    [UIView animateWithDuration:.3 animations:^{
      
        //根据manager改变该label的背景
        self.textColor =[manager getLabelColor];
        
    }];
}


@end
