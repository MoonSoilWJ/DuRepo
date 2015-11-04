//
//  DayNightManager.h
//  知乎日报
//
//  Created by MAC19 on 15/10/25.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kthemeName @"themeChangeName"

#import <UIKit/UIKit.h>
@interface DayNightManager : NSObject

@property(nonatomic,assign) BOOL isNight;

+(DayNightManager*)shareInstance;

-(UIColor *)getLeftColor;
-(UIColor *)getRightColor;
-(UIColor *)getButtonColor;
-(UIColor *)getLabelColor;

-(UIImage *)getImageWithName:(NSString *)imageName;


@end
