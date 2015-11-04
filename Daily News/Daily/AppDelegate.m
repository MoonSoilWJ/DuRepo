//
//  AppDelegate.m
//  Daily
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "BaseNavigationViewController.h"
//#import "MenuViewController.h"
#import "Left.h"
#import "HomeViewController.h"
#import "MessageViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //中间
    _naviVC= [[BaseNavigationViewController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    
    
    
    //左边
    Left *menuVC = [[Left alloc] init];
    
    _mmDrawer= [[MMDrawerController alloc] initWithCenterViewController:_naviVC leftDrawerViewController:menuVC];
    
    //左侧视图宽度
    _mmDrawer.maximumLeftDrawerWidth = 260;
    
    //设置控制区域
    [_mmDrawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_mmDrawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画
    MMDrawerControllerDrawerVisualStateBlock block = [MMDrawerVisualState slideVisualStateBlock];
    [_mmDrawer setDrawerVisualStateBlock:block];
   
    //    //隐藏导航栏
    
 
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    
        
    FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];

    NSUserDefaults *userDafaults = [NSUserDefaults standardUserDefaults];
    
   bool noFirst = [userDafaults boolForKey:@"First"];
  
    if(noFirst)
    {
        
        self.window.rootViewController = firstView;
    }
    
    else
    {
        self.window.rootViewController = _mmDrawer;
    }
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
