//
//  SysUtil.m
//  Travel
//
//  Created by ISS110302000166 on 15-4-2.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "SysUtil.h"

@implementation SysUtil
+ (BOOL) emptyString: (NSString *) aString
{
    return (aString == nil || aString.length == 0 || [aString isEqualToString:@"null"]);
}

+ (NSString *)priceDisplay:(NSString *)price
{
    if([SysUtil emptyString:price]
       || [price floatValue] == 0)
    {
        return @"免费";
    }
    else
    {
        return [NSString stringWithFormat:@"%@", price];
    }
}

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}
+ (NSMutableArray *)tableViewGifHeaderNormalImages
{
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 0; i < 52; i++) {
        NSString *imageName = [NSString stringWithFormat:@"pr_3_%05d.png",i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [idleImages addObject:image];
        }
    }
    return idleImages;
}
@end
