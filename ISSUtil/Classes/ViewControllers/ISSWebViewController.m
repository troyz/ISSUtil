//
//  ISSWebViewController.m
//  XXRun
//
//  Created by iss110302000283 on 15/11/17.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "ISSWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "ISSConstant.h"
#import "SysUtil.h"
#import "UIViewController+ISSUtil.h"

@interface ISSWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
//    UIWebView *webView;
    NJKWebViewProgressView *progressView;
    NJKWebViewProgress *progressProxy;
}
@end

@implementation ISSWebViewController
@synthesize webView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    statusBarView.backgroundColor = RGBColor(0x80, 0x00, 0x17);
    [self.view addSubview:statusBarView];
    
    // Do any additional setup after loading the view.
    CGFloat offsetY = [self isHideNavigationBar] ? 0 : kOffSet;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, offsetY, kScreenWidth, kScreenHeight - offsetY - (_showToolbar ? kTabbarHeight : 0))];
    webView.scrollView.bounces = NO;
    webView.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.view addSubview:webView];
//    webView.delegate = self;
    
    progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = progressProxy;
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    progressView.progressBarView.backgroundColor = [UIColor blueColor];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [progressView setProgress:0 animated:NO];
    
    [webView setScalesPageToFit:YES];
    [self loadWebPage];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [progressView removeFromSuperview];
}

- (void)reloadWebPage
{
    [self loadWebPage];
}

- (void)loadWebPage
{
    if([self.url rangeOfString:@"http"].location != NSNotFound)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [webView loadRequest:request];
    }
    else
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.url ofType:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
        [webView loadRequest:request];
    }
}

//- (void)webViewDidFinishLoad:(UIWebView *)_webView
//{
//    if([SysUtil emptyString:self.navigationItem.title] && !self.navigationItem.titleView)
//    {
//        NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//        if(![SysUtil emptyString:title])
//        {
//            [self setNavigationTitle:title];
//        }
//    }
//}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [progressView setProgress:progress animated:YES];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(![SysUtil emptyString:title])
    {
        self.navigationItem.title = title;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
