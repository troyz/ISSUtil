//
//  UINavigationController+Style.m
//  ASTalent
//
//  Created by iss110302000283 on 15/8/30.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UINavigationController+Style.h"
#import "objc/runtime.h"
#import "ISSConstant.h"

static char barColorKey;
static char barStyleKey;

@implementation UINavigationController (Style)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            Method originMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
            Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzling_pushViewController:animated:));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)swizzling_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = NO;
    [self swizzling_pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if([viewControllerToPresent isKindOfClass:[UINavigationController class]])
    {
        [((UINavigationController *)viewControllerToPresent) setupStyleWithBarColor];
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setupStyleWithBarColor
{
    UIColor *barColor = [self getBarColor];
    UIStatusBarStyle *barStyle = [self getBarStyle];
    [self setupStyleWithBarColor:barColor withBarStyle:barStyle];
}

- (void)setupStyleWithBarColor:(UIColor *)barColor
{
    [self setupStyleWithBarColor:barColor withBarStyle:UIStatusBarStyleLightContent];
}

- (void)setupStyleWithBarColor:(UIColor *)barColor
                  withBarStyle:(UIStatusBarStyle) barStyle
{
    if(!barColor)
    {
        NSLog(@"Invalid barColor");
        return;
    }
    [self setBarColor:barColor];
    [self setBarStyle:barStyle];
    UIColor *uiColor = barColor;
    UIColor *foregroundColor = barStyle == UIStatusBarStyleLightContent ? [UIColor whiteColor] : [UIColor blackColor];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:foregroundColor forKey:NSForegroundColorAttributeName];
    
    UINavigationController *navigationController = self;
    [navigationController.navigationBar setBackgroundColor:uiColor];
    
    navigationController.navigationBar.barTintColor = uiColor;
    navigationController.navigationBar.tintColor = foregroundColor;
    [[UIApplication sharedApplication] setStatusBarStyle:barStyle];
    navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle
{
    objc_setAssociatedObject(self, &barStyleKey, [NSString stringWithFormat:@"%zd", barStyle], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIStatusBarStyle)getBarStyle
{
    NSString *str = objc_getAssociatedObject(self, &barStyleKey);
    return [str integerValue];
}

- (void)setBarColor:(UIColor *)barColor
{
    if(!barColor)
    {
        return;
    }
    objc_setAssociatedObject(self, &barColorKey, [self colorToString:barColor], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)getBarColor
{
    NSString *str = objc_getAssociatedObject(self, &barColorKey);
    return [self stringToColor:str];
}

- (NSString *)colorToString:(UIColor *)color
{
    if(!color)
    {
        return nil;
    }
    CGFloat R, G, B, A;
    CGColorRef colorRef = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(colorRef);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(colorRef);
        R = components[0];
        G = components[1];
        B = components[2];
        A = components[3];
    }
    return [NSString stringWithFormat:@"%f-%f-%f-%f", R, G, B, A];
}

- (UIColor *)stringToColor:(NSString *)str
{
    if(!str)
    {
        return nil;
    }
    NSArray *arr = [str componentsSeparatedByString:@"-"];
    if(arr.count != 4)
    {
        return nil;
    }
    CGFloat R, G, B, A;
    R = [arr[0] floatValue];
    G = [arr[1] floatValue];
    B = [arr[2] floatValue];
    A = [arr[3] floatValue];
    return RGBAColor(R, G, B, A);
}
@end
