//
//  DetailViewController.m
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewExt.h"
#import "ThemeColorView.h"
#import "HomeViewController.h"
#import "ThemeViewController.h"
#import "MJRefresh.h"


@interface DetailViewController ()

{
    NSNumber *_zan;
    NSNumber *_com;
    
    
    NSInteger i;
    NSInteger j;
    
    UIView *_share;
    
    UIButton *_button;
    
    
    NSString *_imageStr;
    NSString *_imageSource;

    
    UILabel *_label;
    UILabel *_sourceLabel;
}
@end

@implementation DetailViewController


-(instancetype)init {
    self = [super init];
    if (self) {
       
          [self createViews];

        
        [self _createBrowserView];
        
        [self _createShareView];

    }
    return self;
}

//分享按钮点击后，出现的View
-(void)_createShareView {

    
    
    _share = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, 375, 0)];
    _share.backgroundColor = [UIColor darkGrayColor];
    [_webView addSubview:_share];
    _share.clipsToBounds = YES;
    
    
    NSArray *imageNames = @[@"Share_WeChat@2x",
                            @"Share_Twitter@2x",
                            @"Share_Tencent@2x",
                            @"Share_Sina@2x",
                            @"Share_Renren@2x",
                            @"Share_QQ@2x",
                            @"Share_Message@2x",
                            @"Share_YoudaoNote@2x",
                            ];
    
    float itemWidth = kScreenWidth/4;
    
    for (int m = 0; m < 2; m++) {
        
        for (int k = 0; k < 4; k ++) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth*k, itemWidth*m, itemWidth, itemWidth)];
            view.image = [UIImage imageNamed:imageNames[m*4+k]];
            
            [_share addSubview:view];
        }
    }
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 175, 30)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 175, 30)];
    label.text = @"取消";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(canShare) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:label];
    
    [_share addSubview:button];

}

-(void)viewWillAppear:(BOOL)animated {

      self.navigationController.navigationBar.hidden = YES;

    
    //获取前一个tableview的cell被点击的时候所在的indexpath，并将indexpath的row和section赋值给i、j。
    i = _indexPath.row;
    j = _indexPath.section;

}

-(void)createViews {
    //create webView and manager
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _webView.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    
    
    _webView.scrollView.showsVerticalScrollIndicator = YES;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_webView];
    
    //Mjrefresh加载上一篇新闻
   MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(lastDetail)];
    
    [header setTitle:@"载入上一篇" forState:MJRefreshStateRefreshing];
    [header setTitle:@"载入上一篇" forState:MJRefreshStateIdle];
    [header setTitle:@"载入上一篇" forState:MJRefreshStatePulling];
    _webView.scrollView.header = header;
    
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextDeail)];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStateIdle];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStatePulling];
    _webView.scrollView.footer = footer;

    
}

-(void)setIsHome:(BOOL)isHome {
    if (_isHome != isHome) {
        _isHome = isHome;
    }
}

-(void)setNewsId:(NSString *)newsId {
    if (_newsId != newsId) {
        _newsId = newsId;
        
        //加载数据
        NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",BaseUrl, news_detail,_newsId];
        NSString *exUrlStr = [NSString stringWithFormat:@"%@story-extra/%@",BaseUrl,_newsId];
        [self loadWebViewWithUrlStr:urlStr];
        [self loadWebViewWithExUrlStr:exUrlStr];
        
        [self reloadInputViews];
    }
}



//将下载的内容显示到webview
-(void)loadWebViewWithUrlStr:(NSString *)urlString {
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (_isHome) {
            if (_headImageView == nil) {
                _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
                _headImageView.backgroundColor = [UIColor clearColor];
                _headImageView.contentMode = UIViewContentModeScaleAspectFill;
                _headImageView.clipsToBounds = YES;
                [_webView.scrollView addSubview:_headImageView];
                
            }
            _imageStr = responseObject[@"image"];
            _imageSource = [responseObject valueForKey:@"image_source"];
            
            
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
            
            
            //创建label
            if (_label == nil) {
                _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth - 10 - 10, 60)];
            }
            
            _label.text = responseObject[@"title"];
            _label.font = [UIFont systemFontOfSize:20];
            _label.textColor = [UIColor whiteColor];
            _label.numberOfLines = 2;
            _label.backgroundColor = [UIColor clearColor];
            [_headImageView addSubview:_label];
            
            if (_sourceLabel == nil) {
                _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 130, 180, 120, 20)];
            }
            
            _sourceLabel.text = _imageSource;
         
            _sourceLabel.font = [UIFont systemFontOfSize:10];
            _sourceLabel.textColor = [UIColor whiteColor];
            [_headImageView addSubview:_sourceLabel];
            
        }
       
 
        NSString *body = responseObject[@"body"];
        NSString *cssUrl = responseObject[@"css"][0];
        NSString *linkString = [NSString stringWithFormat:@"<link rel=\"Stylesheet\" type=\"text/css\" href=\"%@\" />", cssUrl];
        NSString *htmlString = [NSString stringWithFormat:@"%@%@", linkString, body];
        
        [_webView loadHTMLString:htmlString baseURL:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSLog(@"请求失败:%@",error);
    }];
    
    
    
}


//下载该新闻的附属属性，赞的数量、评论的数量
-(void)loadWebViewWithExUrlStr:(NSString *)urlString {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _zan  = [responseObject valueForKey:@"popularity"];
        _com = [responseObject valueForKey:@"comments"];
        
        [self _createBrowserView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSLog(@"请求失败:%@",error);
    }];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}


//下方浏览器视图
-(void)_createBrowserView {

    UIView *browser = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight- 43, kScreenWidth, 44)];
    browser.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_Browser_Navibar@2x"]];
    [self.view addSubview:browser];
    
    
    
    NSArray *imageNames = @[@"News_Navigation_Arrow@2x",
                            @"News_Navigation_Next@2x",
                            @"News_Navigation_Vote@2x",
                            @"News_Navigation_Share@2x",
                            @"News_Navigation_Comment@2x",
                            ];
    
    float itemWidth = kScreenWidth/5;
    
    for (int k = 0; k < 5; k ++) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(itemWidth*k, 0, itemWidth, 44)];
        view.image = [UIImage imageNamed:imageNames[k]];
        
        view.userInteractionEnabled = YES;

        [browser addSubview:view];
        if (k == 0 ) {//返回按钮
            UIButton *button = [[UIButton alloc]initWithFrame:view.bounds];
            [button addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
        if (k == 1) {//下一篇新闻
            UIButton *button = [[UIButton alloc]initWithFrame:view.bounds];
            [button addTarget:self action:@selector(nextDeail) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];

        }
        if (k == 3) {//点击分享
            _button = [[UIButton alloc]initWithFrame:view.bounds];
            [_button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_button];
            
        }

        
        if (k == 4) {//赞的数量
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 3, 50, 20)];

        label.textColor = [UIColor whiteColor];
        label.text = [_zan stringValue];
        label.font = [UIFont systemFontOfSize:10];

        [view addSubview:label];
        }
        
        if (k == 2) {//评论的数量
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 3, 50, 20)];
            
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:10];
            label.text = [_com stringValue];
            [view addSubview:label];
        }
        
    
    }

}

-(void)share:(UIButton *)butt {
    
    if (!butt.selected) {
        
        //从下方缓慢推出shareView
        [UIView animateWithDuration:.8 animations:^{
            _share.frame = CGRectMake(0, kScreenHeight-300, 375, 300);
            
        }];
        
    }
    else
    {
        //隐藏
        [UIView animateWithDuration:.8 animations:^{
            _share.frame = CGRectMake(0, kScreenHeight, 375, 0);
            
        }];

    }
    butt.selected = !butt.selected;
    
}

-(void)canShare {//取消分享
    [UIView animateWithDuration:.8 animations:^{
        _share.frame = CGRectMake(0, kScreenHeight, 375, 0);
        
    }];
    _button.selected = !_button.selected;
}

-(void)backVC {
   
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextDeail {
    
    if (_isHome) {
        //从主页点击进来的
        NSArray *array = _dataArray[j];
        
        
            if (i < array.count) {
                i++;        //下一个NewsId
            }
            else
            {
                if (j<_dataArray.count-1) {
                    j++;    //下一个section，并将newid设置为第一个
                    i=1;
                }
            }
            NSArray *array2 = _dataArray[j];
            HomeModel *model = array2[i-1];
            self.newsId = [model.homeNews_id stringValue];

    }
    
    
    else
    {
        //从其他主题点击进来的
        if (i < _dataArray.count-1) {
            ThemeModel *model = _dataArray[i+1];
            self.newsId = [model.news_id stringValue];
            
            if (i < _dataArray.count-1) {
                
                i++;    //newid+1
            }
        }
        
        
    }
    _webView.top = kScreenHeight-20;
    
    
    //实现视图从下方推出的效果
    [UIView animateWithDuration:0.5 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _webView.top = 0;
    } completion:nil];
    
    
    [_webView.scrollView.footer endRefreshing];

    
}

//上一个新闻页
-(void)lastDetail
{
    
    if (_isHome) {
        
        if (i > 0) {
            i--;
        }
        else
        {
            if (j > 0) {
                j--;
            NSArray *array3 = _dataArray[j];
            i=array3.count-1;
            }
        }
        NSArray *array2 = _dataArray[j];
        
        HomeModel *model = [[HomeModel alloc]init];
        
        if (j==0) { //第一次点击是在home页面的第一个section时，因为headView占用一个cell，newid    的排序和当前cell的排序错开一个
            if (i>0) {
                model = array2[i-1];
            }
            }
        else if (j > 0) {
            model = array2[i];
            }
            self.newsId = [model.homeNews_id stringValue];

    }
    
    
    else
    {
        if (i > 0) {
            ThemeModel *model = _dataArray[i-1];
            self.newsId = [model.news_id stringValue];
            
            i--;
        }
        
        
    }
    _webView.bottom = -20;
    
    [UIView animateWithDuration:0.5 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _webView.top = 0;
    } completion:nil];
    
    
    [_webView.scrollView.header endRefreshing];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
