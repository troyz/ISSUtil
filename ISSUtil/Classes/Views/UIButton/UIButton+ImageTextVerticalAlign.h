//
//  UIButton+ImageTextVerticalAlign.h
//  让UIButton上的文字与图片垂直对齐
//
//  Created by ISS110302000166 on 15/8/4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageTextVerticalAlign)
/**
 *  设置图片、文字垂直对齐，
 *
 *  @param space 图片、文字间距
 *
 *  @return 返回uibutton的size
 */
- (CGSize)centerImageAndTitle:(float)space;
- (CGSize)centerImageAndTitle;

/**
 *  设置图片、文字一行对齐，
 *
 *  @param space 图片、文字间距
 *
 *  @return 返回uibutton的size
 */
- (CGSize)centerLeftRightImageAndTitle:(float)spacing;
- (CGSize)centerLeftRightImageAndTitle;

@end
