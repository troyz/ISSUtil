//
//  NSString+Extension.m
//  UI-QQ
//
//  Created by chenzhe on 15/8/10.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 计算文字的尺寸
 */
- (CGSize)setSizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
}


//把字典转换为json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
