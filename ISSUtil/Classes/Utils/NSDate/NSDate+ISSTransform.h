//
//  NSDate+ISSTransform.h
//  Travel
//
//  Created by 段林波 on 15/3/31.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATE_FORMATE_YMD    @"yyyy-MM-dd"

@interface NSDate (ISSTransform)

+ (NSString*)stringFromDate:(NSDate*)date;//将指定时间转换成字符串(yyyy-MM-dd hh:mm:ss)
+(NSString *)stringFromDate2:(NSDate*)date;//将指定时间转换成字符串(yyyy-MM-dd hh:mm)
+ (NSString*)stringFromDate3:(NSDate*)date;//将指定时间转换成字符串(yyyy-MM-dd)
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)formate;
+ (NSDate *)dateFromString:(NSString*)string;//将格式为：YYYY-MM-DD hh:mm:ss 字符串转换为NSDate类型
+(NSDate *)dateFromString2:(NSString *)string;//pragma mark 将指定指定字符串转换成时间(yyyy-MM-dd hh:mm)
+(NSDate *)dateFromString4:(NSString *)string; //pragma mark 将指定指定字符串转换成时间(yyyy-MM-dd hh:mm:ss.SSS)

+(NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)formate;
// 计算某年某月的天数
- (NSInteger)daysInMonth;
+ (NSInteger)daysInMonth:(NSInteger)month year:(NSInteger)year;
- (NSInteger)getYear;
- (NSInteger)getMonth;
- (NSInteger)getDay;
// x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)dateSince;



+ (NSString*)stringFromFullDateString:(NSString*)dateString;//将指定时间(yyyy-MM-dd hh:mm:ss.SSS)转换成字符串(yyyy-MM-dd)

+ (NSString*)stringFromhafDateString:(NSString*)dateString;//将指定时间(yyyy-MM-dd hh:mm:ss)转换成字符串(MM-dd)

@end
