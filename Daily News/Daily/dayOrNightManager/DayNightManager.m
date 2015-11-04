//
//  DayNightManager.m
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "DayNightManager.h"

@implementation DayNightManager


//单例方法，其中的init方法只能被初始化一次
+(DayNightManager*)shareInstance
{
    static DayNightManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token ,^{
        instance = [[[self class]alloc]init];
    });
    
    return instance;
}




//获取左边背景颜色
-(UIColor *)getLeftColor
{
    if(_isNight)

        return [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1];
    
    else
        return [UIColor colorWithRed:35/255.0 green:42/255.0 blue:47/255.0 alpha:1];

}

//获取右边背景颜色
-(UIColor *)getRightColor
{
    if(_isNight)
        
        return [UIColor colorWithRed:50/255.0 green:50./255.0 blue:50/255.0  alpha:1];
    
    else
        return [UIColor colorWithWhite:.97 alpha:1];

}

//获取按钮的颜色
-(UIColor *)getButtonColor
{
    if(_isNight)
        
        return [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    
    else
        return [UIColor whiteColor];
    

}
//获取视图的背景图片
-(UIImage *)getImageWithName:(NSString *)imageName
{
    if(_isNight)
    {
        NSString * imageNameStr = [NSString stringWithFormat:@"Dark_%@",imageName];
        return [UIImage imageNamed:imageNameStr];
    }
    else
        return [UIImage imageNamed:imageName];

}

//获取 label 字体颜色
-(UIColor *)getLabelColor
{
    if(_isNight)
        return [UIColor colorWithWhite:.7 alpha:1];
    else
        return [UIColor blackColor];

}

@end
