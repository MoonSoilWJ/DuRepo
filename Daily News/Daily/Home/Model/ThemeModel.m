//
//  NewsMode.m
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel

-(NSDictionary *)attributeMapDictionary {
    
    NSDictionary *dic = @{
                          @"title" : @"title",
                          @"images" : @"images",
                          @"type" : @"type",
                          @"news_id" : @"id",
                          };
    return dic;
}

@end
