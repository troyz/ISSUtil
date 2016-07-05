//
//  NSMutableAttributedString+HTML.m
//  Travel
//
//  Created by ISS110302000166 on 15/6/10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "NSMutableAttributedString+HTML.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (HTML)
// appends a plain string extending the attributes at this position
- (void)appendString:(NSString *)string
{
    string = !string ? @"" : string;
    NSParameterAssert(string);
    
    NSUInteger length = [self length];
    NSAttributedString *appendString = nil;
    
    if (length)
    {
        // get attributes at end of self
        NSMutableDictionary *attributes = [[self attributesAtIndex:length-1 effectiveRange:NULL] mutableCopy];
        
        // we need to remove the image placeholder (if any) to prevent duplication
        [attributes removeObjectForKey:NSAttachmentAttributeName];
        [attributes removeObjectForKey:(id)kCTRunDelegateAttributeName];
        
        // we also remove field attribute, because appending plain strings should never extend an field
//        [attributes removeObjectForKey:DTFieldAttribute];
        
        // create a temp attributed string from the appended part
        appendString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    }
    else
    {
        // no attributes to extend
        appendString = [[NSAttributedString alloc] initWithString:string];
    }
    
    [self appendAttributedString:appendString];
}

@end
