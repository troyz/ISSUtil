//
//  UITextField+LengthLimit.h
//  Travel
//
//  Created by iss110302000283 on 15/10/30.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (LengthLimit)
- (void)addLengthLimit:(NSInteger)maxLength withTextField:(UITextField *)textField;
- (void)removeTextFieldLengthLimit:(UITextField *)textField;
- (void)categoryTextFieldDidChange:(UITextField *)textField;
@end
