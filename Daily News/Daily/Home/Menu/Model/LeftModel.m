//
//  LeftModel.m
//  知乎日报
//
//  Created by MAC19 on 15/10/24.
//  Copyright (c) 2015年 MAC19. All rights reserved.
//

#import "LeftModel.h"

@implementation LeftModel
-(NSDictionary *)attributeMapDictionary
{
    NSDictionary *mapAtt = @{
                             @"titleId":@"id",
                             @"name":@"name"
                             };
    
    return mapAtt;
    
}

@end
