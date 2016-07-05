//
//  NSString+ISSReplace.h
//  Travel
//
//  Created by 段林波 on 15/3/31.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ISSReplace)

/*
 *去掉指定字符串中html标记
 *html:包含html标记字符串 trim:是否删除首尾的空格和回车
 */
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;


/**
 *  去掉指定字符串中指定标记
 *
 *  @param str          指定字符串
 *  @param beginMarkStr 标记开始
 *  @param endMarkStr   标记结束
 *  @param trim         是否删除首位的空格和回车
 *
 *  @return <#return value description#>
 */
+(NSString*)removeStr:(NSString *)str
         beginMarkStr:(NSString*)beginMarkStr
           endMarkStr:(NSString*)endMarkStr
       trimWhiteSpace:(BOOL)trim;

@end
