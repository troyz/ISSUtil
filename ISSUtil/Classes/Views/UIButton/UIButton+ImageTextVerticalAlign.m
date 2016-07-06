//
//  UIButton+ImageTextVerticalAlign.m
//  Travel
//
//  Created by ISS110302000166 on 15/8/4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UIButton+ImageTextVerticalAlign.h"
#import "UITool.h"

@implementation UIButton (ImageTextVerticalAlign)
- (CGSize)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [UITool sizeWithText:self.titleLabel.text withMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) withFont:self.titleLabel.font lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat totalWidth = imageSize.width > titleSize.width ? imageSize.width : titleSize.width;
   // imageSize.width = imageSize.width > titleSize.width ? imageSize.width : titleSize.width;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width  , - (totalHeight - titleSize.height),0.0);
    
    return CGSizeMake(totalWidth, totalHeight);
}

- (CGSize)centerImageAndTitle
{
    const int DEFAULT_SPACING = 5.0f;
    return [self centerImageAndTitle:DEFAULT_SPACING];
}


- (CGSize)centerLeftRightImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [UITool sizeWithText:self.titleLabel.text withMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) withFont:self.titleLabel.font lineBreakMode:NSLineBreakByWordWrapping];
    //
    CGFloat totalHeight = imageSize.height > titleSize.height ? imageSize.height : titleSize.height;
    
    // get the height they will take up as a unit
    CGFloat totalWidth = (imageSize.width + titleSize.width + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(0, - spacing/2., 0 , 0);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0  , 0 ,- spacing/2.);
    
    return CGSizeMake(totalWidth, totalHeight);
}

- (CGSize)centerLeftRightImageAndTitle
{
    const int DEFAULT_SPACING = 5.0f;
    return [self centerLeftRightImageAndTitle:DEFAULT_SPACING];
}

@end