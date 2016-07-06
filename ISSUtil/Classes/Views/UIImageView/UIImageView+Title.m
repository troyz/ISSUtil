//
//  UIImageView+Title.m
//  Travel
//
//  Created by ISS110302000166 on 15-4-23.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UIImageView+Title.h"
#import "UITool.h"
#import "ISSConstant.h"

#define fontSize    11
#define hmargin     3.0
#define vmargin     3.0
#define TAG_TITLE   1

@implementation UIImageView (Title)
- (void) setImageTitle:(NSString *)title
{
    if(self.subviews && self.subviews.count > 0)
    {
        for(NSInteger i = self.subviews.count - 1; i >= 0; i--)
        {
            UIView *view = [self.subviews objectAtIndex:i];
            if(view.tag == TAG_TITLE)
            {
                [view removeFromSuperview];
            }
        }
    }
    
    CGFloat titleMaxWidth = self.frame.size.width - 2 * hmargin;
    
    CGSize titleMaxSize = [UITool sizeWithText:@"\n" withMaxSize:CGSizeMake(titleMaxWidth, MAXFLOAT) withFontSize:fontSize lineBreakMode:NSLineBreakByTruncatingTail];
    
    CGSize titleSize = [UITool sizeWithText:title withMaxSize:CGSizeMake(titleMaxWidth, MAXFLOAT) withFontSize:fontSize lineBreakMode:NSLineBreakByTruncatingTail];
    
    if(titleSize.height > titleMaxSize.height)
    {
        titleSize.height = titleMaxSize.height;
    }
    
    CGFloat height = (titleMaxSize.height + 2 * vmargin);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height)];
    bgView.tag = TAG_TITLE;
    bgView.backgroundColor = RGBAColor(0x0, 0x0, 0x0, 0.5);
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(hmargin, (height - titleSize.height) / 2.0, titleSize.width, titleSize.height)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont systemFontOfSize:fontSize];
    titleView.text = title;
    titleView.numberOfLines = 0;
    titleView.lineBreakMode = NSLineBreakByTruncatingTail;
    titleView.textColor = [UIColor whiteColor];
    
    [bgView addSubview:titleView];
    [self addSubview:bgView];
}
@end
