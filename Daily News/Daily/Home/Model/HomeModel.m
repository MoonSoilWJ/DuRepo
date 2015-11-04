//
//  HomeModel.m
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(NSDictionary *)attributeMapDictionary {
    
    NSDictionary *dic = @{
                          @"title":@"title",
                          @"images":@"images",
                          @"type":@"type",
                          @"homeNews_id":@"id",
                          @"ga_prefix":@"ga_prefix",
                          };
    return dic;

}


@end
