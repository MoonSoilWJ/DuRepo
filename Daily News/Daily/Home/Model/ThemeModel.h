//
//  NewsMode.h
//  Daily
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface ThemeModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *news_id;

@end
