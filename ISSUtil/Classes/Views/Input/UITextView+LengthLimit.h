//
//  UITextView+LengthLimit.h
//  Travel
//
//  Created by iss110302000283 on 15/10/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (LengthLimit)
- (void)addLengthLimit:(NSInteger)maxLength withTextView:(UITextView *)textView;
- (void)removeTextViewLengthLimit:(UITextView *)textView;
- (void)categoryTextViewDidChange:(UITextView *)textView;
@end
