//
//  ISSAppDelegate.m
//  ISSUtil
//
//  Created by Troy Zhang on 07/04/2016.
//  Copyright (c) 2016 Troy Zhang. All rights reserved.
//

#import "ISSAppDelegate.h"
#import "ISSUtil.h"

@implementation ISSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = @"First Page";
    
    UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView setTitle:@"下一页面" forState:UIControlStateNormal];
    btnView.frame = CGRectMake(50, kOffSet + 50, 100, 40);
    btnView.titleLabel.textColor = [UIColor blackColor];
    btnView.backgroundColor = [UIColor orangeColor];
    [btnView addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btnView];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [navController setupStyleWithBarColor:RGBColor(0xff, 0x66, 0x00)];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)buttonTapped
{
//    UINavigationController *navController = self.window.rootViewController;
//    ISSWebViewController *vc = [[ISSWebViewController alloc] initWithHideNavgationBar:YES];
//    vc.url = @"http://www.baidu.com/";
//    [vc initBackButton];
//    [navController pushViewController:vc animated:YES];
    
    NSDictionary *dict = @{@"cityname": @"武汉"};
    NSString *theurl = @"http://apis.baidu.com/apistore/weatherservice/cityname";
    [[ISSHttpClient sharedInstance] setRequestInjection:^(AFHTTPRequestSerializer *request, NSString *url, NSDictionary *dict) {
        if([url isEqualToString:theurl])
        {
            [request setValue:@"e0f995d5d2e6d61784c144683b7ff96c" forHTTPHeaderField:@"apikey"];
        }
    }];
    [[ISSHttpClient sharedInstance] getJSON:theurl withKVDict:dict withBlock:^(ISSHttpError errorCode, id jsonData) {
        NSLog(@"type, %@", [jsonData class]);
        NSLog(@"jsonData %@", jsonData);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
