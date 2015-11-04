//
//  BaseModel.h
//  BaseModalTest
//
//  Created by gj on 15/8/22.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <Foundation/Foundation.h>

// @property (nonamic,copy)NSString *userName
// 数据字典   key ：user_name



@interface BaseModel : NSObject

/**
    建立映射字典
  { key =  propertyName：value = 字段name(数据字典的key)}
    userName ： user_name
 
 */


//初始化方法
-(id)initWithDataDic:(NSDictionary*)dataDic;

//属性映射字典
- (NSDictionary*)attributeMapDictionary;

//设置属性
- (void)setAttributes:(NSDictionary*)dataDic;

@end
