//
//  ISSViewController.m
//  Travel
//
//  Created by ISS110302000166 on 15-3-30.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "ISSViewController.h"

@interface ISSViewController ()
{
    BOOL hideNavigationBar;
//    MBProgressHUD* _HUMMsg;
}
@end

@implementation ISSViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColor_Bg_Gray; //[UIColor whiteColor];
    [self addFirstView];
}

- (instancetype)initWithHideNavgationBar:(BOOL)_hideNavigationBar
{
    self = [super init];
    if(self)
    {
        hideNavigationBar = _hideNavigationBar;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = hideNavigationBar;
    // 这里处理后，从有bar的VC到无bar的VC不会那么突兀。
    [self.navigationController setNavigationBarHidden:hideNavigationBar animated:animated];
}
@end
