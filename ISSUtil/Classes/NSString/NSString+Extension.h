//
//  NSString+Extension.h
//  UI-QQ
//
//  Created by chenzhe on 15/8/10.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Extension)

- (CGSize)setSizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
