//
//  NSString+ISSReplace.m
//  Travel
//
//  Created by 段林波 on 15/3/31.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "NSString+ISSReplace.h"

@implementation NSString (ISSReplace)

+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim{
    
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+ (NSString *)removeStr:(NSString *)str beginMarkStr:(NSString *)beginMarkStr endMarkStr:(NSString *)endMarkStr trimWhiteSpace:(BOOL)trim {

    NSScanner *theScanner = [NSScanner scannerWithString:str];
    NSString *text = nil;
    
    // find start of tag
    [theScanner scanString:beginMarkStr intoString:NULL];
    // find end of tag
    [theScanner scanUpToString:endMarkStr intoString:&text] ;
    
    
//    while ([theScanner isAtEnd] == NO) {
//        // find start of tag
//        [theScanner scanString:beginMarkStr intoString:NULL];
//        // find end of tag
//        [theScanner scanUpToString:endMarkStr intoString:&text] ;
//        // replace the found tag with a space
//        //(you can filter multi-spaces out later if you wish)
////        str = [str stringByReplacingOccurrencesOfString:
////                [ NSString stringWithFormat:@"%@%@", text, endMarkStr]
////                                               withString:text];
//         str = text;
//        NSLog(@"str=%@",str);
//    }
    
    str = text;
    
    return trim ? [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : str;

}
@end
