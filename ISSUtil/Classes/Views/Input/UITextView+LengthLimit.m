//
//  UITextView+LengthLimit.m
//  Travel
//
//  Created by iss110302000283 on 15/10/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "UITextView+LengthLimit.h"
#import "objc/runtime.h"
#import "SysUtil.h"

static char textViewMaxLengthKey;

@implementation NSObject (LengthLimit)
- (void)addLengthLimit:(NSInteger)maxLength withTextView:(UITextView *)textView
{
    [self removeTextViewLengthLimit:textView];
    textView.delegate = self;
    
    [self setTextViewMaxLength:maxLength withTextView:textView];
}

- (void)removeTextViewLengthLimit:(UITextView *)textView
{
    textView.delegate = nil;
}

- (void)setTextViewMaxLength:(NSInteger)maxLength withTextView:(UITextView *)textView
{
    objc_setAssociatedObject(textView, &textViewMaxLengthKey, [NSString stringWithFormat:@"%zd", maxLength], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)getTextViewMaxLength:(UITextView *)textView
{
    NSString *str = objc_getAssociatedObject(textView, &textViewMaxLengthKey);
    return [str integerValue];
}

- (BOOL)hasTextViewLengthLimit:(UITextView *)textView
{
    NSString *str = objc_getAssociatedObject(textView, &textViewMaxLengthKey);
    return ![SysUtil emptyString:str];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self hasTextViewLengthLimit:textView] && textView.text.length >= [self getTextViewMaxLength:textView] && text.length > range.length)
    {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([self hasTextViewLengthLimit:textView])
    {
        NSInteger maxLength = [self getTextViewMaxLength:textView];
        if (textView.markedTextRange == nil && maxLength > 0 && textView.text.length > maxLength)
        {
            textView.text = [textView.text substringToIndex:maxLength];
        }
        [self categoryTextViewDidChange:textView];
    }
}

- (void)categoryTextViewDidChange:(UITextView *)textView
{
    
}
@end
