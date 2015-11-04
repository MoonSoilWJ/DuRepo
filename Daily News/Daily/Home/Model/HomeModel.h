//
//  HomeModel.h
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, retain) NSNumber *homeNews_id;
@property (nonatomic, copy) NSString *ga_prefix;

@end
