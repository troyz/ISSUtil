//
//  Constant.h
//  Pods
//
//  Created by xdzhangm on 16/7/6.
//
//

#ifndef Constant_h
#define Constant_h

#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                   [[UIScreen mainScreen] bounds].size.height

#define RGBAColor(r,g,b,a)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBColor(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1)]
#define kTabbarHeight                   49
#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }

#endif /* Constant_h */
