//
//  LogViewController.h
//  知乎日报
//
//  Created by MAC19 on 15/10/26.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "ThemeVC.h"

@interface LogViewController : ThemeVC

@property(nonatomic,copy) NSString *tag;

@end
