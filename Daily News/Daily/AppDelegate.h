//
//  AppDelegate.h
//  Daily
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "BaseNavigationViewController.h"
#import "FirstViewController.h"
#import "Left.h"
#import "HomeViewController.h"
#import "MessageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) MMDrawerController *mmDrawer;
@property(nonatomic,strong) BaseNavigationViewController *naviVC;

@end

