//
//  TopModel.h
//  Daily
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//
/* 
 home的头视图上面的5张图片的model
 */

#import "BaseModel.h"

@interface TopModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, retain) NSNumber *top_id;
@property (nonatomic, copy) NSString *ga_prefix;

@end
