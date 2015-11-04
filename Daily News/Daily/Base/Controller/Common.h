//
//  Common.h
//  Daily
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#ifndef Daily_Common_h
#define Daily_Common_h
#define kthemeName @"themeChangeName"


#import "UIImageView+WebCache.h"
#import "Date.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define BaseUrl         @"http://news-at.zhihu.com/api/4/"
#define start_image     @"start-image/1080*1776"      //启动图片
#define version_sarch   @"version/ios/2.3.0"          //版本查询
#define news_latest     @"news/latest"                //最新资讯
#define news_detail     @"news/"                      //离线下载
#define news_history    @"news/before/"               //历史纪录，2013+11+19
#define news_common     @"story-extra/#{id}"          //新闻的赞,评论  新闻id
#define news_longCommon @"story/#{id}/long-comments"  //长评论
#define list            @"themes"                     //主题列表
#define theme_news      @"theme/"                   //主题新闻
#define news_hot        @"news/hot"                   //热门新闻




#endif