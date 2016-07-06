//
//  UITextField+LengthLimit.m
//  Travel
//
//  Created by iss110302000283 on 15/10/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "UITextField+LengthLimit.h"
#import "objc/runtime.h"
#import "SysUtil.h"

static char textFieldMaxLengthKey;

@implementation NSObject (LengthLimit)
- (void)addLengthLimit:(NSInteger)maxLength withTextField:(UITextField *)textField
{
    [self removeTextFieldLengthLimit:textField];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self setTextFieldMaxLength:maxLength withTextField:textField];
}

- (void)removeTextFieldLengthLimit:(UITextField *)textField
{
    textField.delegate = nil;
    [textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setTextFieldMaxLength:(NSInteger)maxLength withTextField:(UITextField *)textField
{
    objc_setAssociatedObject(textField, &textFieldMaxLengthKey, [NSString stringWithFormat:@"%zd", maxLength], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)getTextFieldMaxLength:(UITextField *)textField
{
    NSString *str = objc_getAssociatedObject(textField, &textFieldMaxLengthKey);
    return [str integerValue];
}

- (BOOL)hasTextFieldLengthLimit:(UITextField *)textField
{
    NSString *str = objc_getAssociatedObject(textField, &textFieldMaxLengthKey);
    return ![SysUtil emptyString:str];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([self hasTextFieldLengthLimit:textField])
    {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > [self getTextFieldMaxLength:textField])
        {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if([self hasTextFieldLengthLimit:textField])
    {
        NSInteger maxLength = [self getTextFieldMaxLength:textField];
        if (textField.text.length > maxLength)
        {
            textField.text = [textField.text substringToIndex:maxLength];
        }
    }
    [self categoryTextFieldDidChange:textField];
}

- (void)categoryTextFieldDidChange:(UITextField *)textField
{
    
}
@end
