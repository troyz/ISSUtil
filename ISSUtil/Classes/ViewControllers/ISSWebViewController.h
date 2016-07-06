//
//  ISSWebViewController.h
//  XXRun
//
//  Created by iss110302000283 on 15/11/17.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSViewController.h"

@interface ISSWebViewController : ISSViewController
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL showToolbar;
- (void)reloadWebPage;
@end
