//
//  NSDate+ISSGetDate.m
//  Travel
//
//  Created by 段林波 on 15/5/4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "NSDate+ISSGetDate.h"

@implementation NSDate (ISSGetDate)

#pragma mark 获取当前日期(格式:年-月-日 时:分:秒)
+(NSString *)getDateFromYMDHMS {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark 获取当前日期(格式:年-月-日)
+(NSString *)getDateFromYMD {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
    
}

#pragma mark 获取当前日期 + days天(格式:年-月-日)
+ (NSString *)getDateFromYMDPlus:(NSInteger)days {
    NSDate *newDate =  [[NSDate date] initWithTimeInterval:24 *60 * 60 * days sinceDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:newDate];
}

#pragma mark 获取当前日期 - days天(格式:年-月-日)
+(NSString *)getDateFromYMDMinus:(NSInteger)days {
    NSDate *newDate =  [[NSDate date] initWithTimeInterval:-1 * 24 *60 * 60 * days sinceDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:newDate];
}

@end
