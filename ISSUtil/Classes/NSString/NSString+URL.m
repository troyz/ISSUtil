//
//  NSString+URL.m
//  YeSanPo
//
//  Created by xdzhangm on 16/6/20.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
- (NSDictionary *)urlParameterDictionary
{
    NSString *urlString = [NSURL URLWithString:self].query;
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [urlString componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSRange range = [keyValuePair rangeOfString:@"="];
        if(range.location == NSNotFound)
        {
            continue;
        }
        NSString *key = [[keyValuePair substringToIndex:range.location] stringByRemovingPercentEncoding];
        NSString *value = [[keyValuePair substringFromIndex:range.location + 1] stringByRemovingPercentEncoding];
        if(!key || !value)
        {
            continue;
        }
        [queryStringDictionary setObject:value forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:queryStringDictionary];
}
@end
