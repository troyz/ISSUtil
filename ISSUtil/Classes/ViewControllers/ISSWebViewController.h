//
//  ISSWebViewController.h
//  XXRun
//
//  Created by iss110302000283 on 15/11/17.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSWebViewController : UIViewController
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL showToolbar;
@property (nonatomic, strong, readonly) UIWebView *webView;
- (void)reloadWebPage;
@end
