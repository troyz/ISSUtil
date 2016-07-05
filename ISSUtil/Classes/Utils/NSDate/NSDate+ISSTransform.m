//
//  NSDate+ISSTransform.m
//  Travel
//
//  Created by 段林波 on 15/3/31.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "NSDate+ISSTransform.h"

@implementation NSDate (ISSTransform)

#pragma mark 将指定时间转换成字符串(yyyy-MM-dd hh:mm:ss)
+(NSString *)stringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CMT+8"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark 将指定时间转换成字符串(yyyy-MM-dd hh:mm)
+(NSString *)stringFromDate2:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CMT+8"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark 将指定时间转换成字符串(yyyy-MM-dd)
+ (NSString*)stringFromDate3:(NSDate*)date;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CMT+8"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter stringFromDate:date];
}

#pragma mark 将指定指定字符串转换成时间(yyyy-MM-dd hh:mm:ss)
+(NSDate *)dateFromString:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:string];
}

#pragma mark 将指定指定字符串转换成时间(yyyy-MM-dd hh:mm)
+(NSDate *)dateFromString2:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter dateFromString:string];
}

+(NSDate *)dateFromString4:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    return [dateFormatter dateFromString:string];
}

+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter dateFromString:dateString];
}

- (NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    return comps;
}

- (NSInteger)getYear
{
    return [[self getDateComponents] year];
}

- (NSInteger)getMonth
{
    return [[self getDateComponents] month];
}

- (NSInteger)getDay
{
    return [[self getDateComponents] day];
}

- (NSInteger)daysInMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    return days.length;
}

+ (NSInteger)daysInMonth:(NSInteger)month year:(NSInteger)year
{
    NSDate *date = [self dateFromString:[NSString stringWithFormat:@"%zd-%zd-01 00:00:00", year, month] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [date daysInMonth];
}

- (NSString *)dateSince
{
    // 把日期字符串格式化为日期对象
    NSDate *date = self;
    
    NSDate *curDate = [NSDate date];
    NSDate *_curDate = [NSDate dateFromString:[NSString stringWithFormat:@"%zd-%zd-%zd 23:59:59", [curDate getYear], [curDate getMonth], [curDate getDay]] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    NSTimeInterval _time = -[date timeIntervalSinceDate:_curDate];
    
    
    int month = (int)([curDate getMonth] - [date getMonth]);
    int year = (int)([curDate getYear] - [date getYear]);
    int day = (int)([curDate getDay] - [date getDay]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600)
    {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        if(retTime < 1)
        {
            return @"刚刚";
        }
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24)
    {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (_time < 3600 * 24 * 2)
    {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate getMonth] == 1 && [date getMonth] == 12)) {
        NSInteger retDay = 0;
        // 同年
        if (year == 0)
        {
            // 同月
            if (month == 0)
            {
                retDay = day;
            }
        }
        if (retDay <= 0) {
            // 这里按月最大值来计算
            // 获取发布日期中，该月总共有多少天
            NSInteger totalDays = [NSDate daysInMonth:[date getMonth] year:[date getYear]];
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = [curDate getDay] + (totalDays - [date getDay]);
            
            if (retDay >= totalDays) {
                return [NSString stringWithFormat:@"%d个月前", (abs)(MAX((int)retDay / 31, 1))];
            }
        }
        return [NSString stringWithFormat:@"%d天前", (abs)((int)retDay)];
    }
    else
    {
        if (abs(year) <= 1)
        {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 相差一年
            int month = (int)[curDate getMonth];
            int preMonth = (int)[date getMonth];
            
            // 隔年，但同月，就作为满一年来计算
            if (month == 12 && preMonth == 12)
            {
                return @"1年前";
            }  
            
            // 也不看，但非同月  
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];  
        }
        return [NSString stringWithFormat:@"%d年前", abs(year)];  
    }
    return @"1小时前";
}

+ (NSString*)stringFromFullDateString:(NSString*)dateString{
    return [NSDate stringFromDate3:[NSDate dateFromString4:dateString]];
}

+ (NSString*)stringFromhafDateString:(NSString*)dateString
{
    return [NSDate stringFromDate:[NSDate dateFromString:dateString] withDateFormat:@"MM-dd"];
}


@end
