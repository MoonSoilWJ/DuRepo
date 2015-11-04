//
//  TopModel.m
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

-(NSDictionary *)attributeMapDictionary {
    
    NSDictionary *dic = @{
                          @"title":@"title",
                          @"image":@"image",
                          @"type":@"type",
                          @"top_id":@"id",
                          @"ga_prefix":@"ga_prefix",
                          };
    return dic;
  
}


@end
