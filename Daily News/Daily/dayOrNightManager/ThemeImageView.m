//
//  ThemeImage.m
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "ThemeImageView.h"
#import "DayNightManager.h"

@implementation ThemeImageView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageNotiAction) name:kthemeName object:nil];
    }
    return self;
    
}

//响应方法
-(void)imageNotiAction
{
    DayNightManager *manager = [DayNightManager shareInstance];
    
    [UIView animateWithDuration:.3 animations:^{
        
    self.image = [manager getImageWithName:_imageName];
    
    }];
}

-(void)setImageName:(NSString *)imageName
{

    if (_imageName != imageName) {
        _imageName = [imageName copy];
    }
    
    [self _loadImage];
}

-(void)_loadImage
{

    self.image = [UIImage imageNamed:_imageName];

}


@end
