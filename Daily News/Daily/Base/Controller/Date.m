//
//  date.m
//  da
//
//  Created by mac on 15/10/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "Date.h"

@implementation Date

-(NSDate *)getNowDate {

    now = [NSDate date];

    return now;
    ;
}


//传入一个时间
-(NSArray *)loadDate:(NSDate *)now1 {
    
//    _now = now;
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    //产生年月日时分秒
    NSInteger year,month,day ,week;
    NSString *weekStr=nil;
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday ;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    comps = [calendar components:unitFlags fromDate:now1];
    year = [comps year];
    week = [comps weekday];
    month = [comps month];
    day = [comps day];
//    hour = [comps hour];
//    min = [comps minute];
//    sec = [comps second];
    
    if(week==1)
    {
        weekStr =@"星期天";
    }else if(week==2){
        weekStr=@"星期一";
        
    }else if(week==3){
        weekStr=@"星期二";
        
    }else if(week==4){
        weekStr=@"星期三";
        
    }else if(week==5){
        weekStr=@"星期四";
        
    }else if(week==6){
        weekStr=@"星期五";
        
    }else if(week==7){
        weekStr=@"星期六";
        
    }
    else {
//        NSLog(@"error!");
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%li月%li日 %@",month,day,weekStr];
    NSString *string = [NSString stringWithFormat:@"%.4li%.2li%.2li",year,month,day];
    [dateArray addObject:string];
//    [dateArray addObject:now];
    [dateArray addObject:dateStr];
    
    return dateArray;
    
}

-(NSDate *)getOldDateWithDays:(NSInteger)days {

    if (now == nil) {
        now = [NSDate date];
    }
    
    NSDate *old = [NSDate dateWithTimeIntervalSinceNow:-(days * 24 * 3600)];
    
    return old;
}


@end
