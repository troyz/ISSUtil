//
//  UINavigationController+Style.m
//  ASTalent
//
//  Created by iss110302000283 on 15/8/30.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UINavigationController+Style.h"
#import "objc/runtime.h"
#import "UIImage+RTTint.h"

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
        [((UINavigationController *)viewControllerToPresent) setupStyle];
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setupStyle
{
    UIColor *uiColor = kColor_Bar;
    UIColor *foregroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    UINavigationController *navigationController = self;
    [navigationController.navigationBar setBackgroundColor:uiColor];
    
    navigationController.navigationBar.barTintColor = uiColor;
    navigationController.navigationBar.tintColor = foregroundColor;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    navigationController.navigationBar.titleTextAttributes = dict;
}
@end
