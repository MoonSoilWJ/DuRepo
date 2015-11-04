//
//  DetailViewController.h
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "TopModel.h"
#import "Common.h"
#import "AFNetworking.h"
#import "ThemeModel.h"
#import "HomeViewController.h"
//#import "BaseViewController.h"

@interface DetailViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate,UIGestureRecognizerDelegate>
{
    //top . home
    UIImageView *_headImageView;
    UIWebView *_webView;
    
    NSString *_imageUrlStr;

}

@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, assign) BOOL isHome;

@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong) NSIndexPath *indexPath;

@end
