//
//  UIImage+Blurry.h
//
//  IOS7 毛玻璃效果
//
//  Created by ISS110302000166 on 15/5/18.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blurry)
- (UIImage *) blurryImageWithBlurLevel:(CGFloat)blur;
+ (UIImage *) blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
