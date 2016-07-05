//
//  NSDate+ISSGetDate.h
//  Travel
//
//  Created by 段林波 on 15/5/4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISSGetDate)

/**
 *  获取当前日期(格式:年-月-日 时:分:秒)
 *
 *  @return <#return value description#>
 */
+ (NSString*)getDateFromYMDHMS;

/**
 *  获取当前日期(格式:年-月-日)
 *
 *  @return <#return value description#>
 */
+ (NSString*)getDateFromYMD;

/**
 *  获取当前日期 + days天(格式:年-月-日)
 *
 *  @param days 加上指定的天数
 *
 *  @return NSString:年-月-日
 */
+ (NSString*)getDateFromYMDPlus:(NSInteger)days;

/**
 *  获取当前日期 - days天(格式:年-月-日)
 *
 *  @param days 减去指定的天数
 *
 *  @return NSString:年-月-日
 */
+ (NSString*)getDateFromYMDMinus:(NSInteger)days;

@end
