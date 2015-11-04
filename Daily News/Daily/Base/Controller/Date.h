//
//  date.h
//  da
//
//  Created by mac on 15/10/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Date : NSObject
{
    NSDate *now;
}

-(NSDate *)getNowDate;
-(NSArray *)loadDate:(NSDate *)now1;
-(NSDate *)getOldDateWithDays:(NSInteger)days;


@end
