//
//  UIViewController+ISSViewController.m
//  Travel
//
//  Created by 段林波 on 15/4/8.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "UIViewController+ISSUtil.h"
#import "objc/runtime.h"
#import "UIImage+RTTint.h"
#import "ISSWebViewController.h"
#import "UINavigationController+Style.h"
#import "ISSConstant.h"
#import "SysUtil.h"
#import "MBProgressHUD.h"
#import "UITool.h"

#define HUB_VIEW_TAG            -10

static char disableSwipBackKey;
static char viewInPagerKey;
static char hideNavBarKey;

@implementation UIViewController (ISSUtil)
- (instancetype)initWithHideNavgationBar:(BOOL)_hideNavigationBar
{
    self = [super init];
    if(self)
    {
        [self setHideNavigationBar:_hideNavigationBar];
    }
    return self;
}

- (void) startLoading
{
    [self startLoadingFromView:self.view];
}

- (void) startLoadingWithMessage:(NSString *)message
{
    [self startLoadingFromView:self.view withMessage:message];
}

- (void) stopLoading
{
    [self stopLoadingFromView:self.view];
}

- (void) startLoadingFromView:(UIView *)pView
{
    [self startLoadingFromView:pView withMessage:nil];
}

- (void) startLoadingFromView:(UIView *)pView withMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:pView animated:YES];
    if(![SysUtil emptyString:message])
    {
        [hud setLabelFont:[UIFont systemFontOfSize:13.0]];
        hud.labelText = message;
    }
}

- (void) stopLoadingFromView:(UIView *)pView
{
    if([NSThread isMainThread])
    {
        [MBProgressHUD hideHUDForView:pView animated:YES];
    }
    else
    {
        void (^theBlock)(void) = ^(void){[MBProgressHUD hideHUDForView:pView animated:NO];};
        dispatch_main_async_safe(theBlock);
    }
}

- (BOOL) checkHttpError:(ISSHttpError) errorCode
{
    switch (errorCode)
    {
        case HTTP_ERROR_NONE:
            return YES;
        case HTTP_ERROR_NETWORK:
            [self showAlert:@"网络连接异常"];
            break;
        case HTTP_ERROR_SERVER:
            [self showAlert:@"服务器端异常"];
            break;
        case HTTP_ERROR_TIMEOUT:
            [self showAlert:@"请求超时"];
            break;
        case HTTP_ERROR_DATA_PARSE:
            [self showAlert:@"数据解析异常"];
            break;
    }
    return NO;
}

- (void) backToPre
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[SysUtil emptyString:msg] ? @"" : msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}



- (void)addFirstView
{
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)]];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController] || [self isDisableSwipBack])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ![self isDisableSwipBack];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ![self isDisableSwipBack] && [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}

- (void) removePopGuesture
{
    [self setDisableSwipBack:YES];
}

- (void)setDisableSwipBack:(BOOL)disableSwipBack
{
    objc_setAssociatedObject(self, &disableSwipBackKey, [NSString stringWithFormat:@"%zd", disableSwipBack], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isDisableSwipBack
{
    NSString *str = objc_getAssociatedObject(self, &disableSwipBackKey);
    return ![SysUtil emptyString:str] && [str integerValue];
}

- (void)setViewInPager:(BOOL)viewInPager
{
    objc_setAssociatedObject(self, &viewInPagerKey, [NSString stringWithFormat:@"%zd", viewInPager], OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removePopGuesture];
}

- (BOOL)isViewInPager
{
    NSString *str = objc_getAssociatedObject(self, &viewInPagerKey);
    return ![SysUtil emptyString:str] && [str integerValue];
}

- (void) isDataNullTarget:(id)target action:(SEL)action
{
    [self isDataNullTarget:target action:action title:nil];
}

- (void) isDataNullTarget:(id)target action:(SEL)action title:(NSString*)title
{
    UIView *nullDataView = [self.view viewWithTag:999];
    
    if (nullDataView == nil)
    {
        nullDataView = [[UIView alloc] init];
        CGSize labelSize = [UITool sizeWithText:([SysUtil emptyString:title] ? @"空空如也,点击刷新" : title) withMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByTruncatingTail];
        CGFloat width = (labelSize.width > 80 ? labelSize.width : 80);
        CGRect viewFrame = CGRectMake((self.view.frame.size.width - width) / 2.0, (self.view.frame.size.height - 120) / 2.0, width, 120);
        nullDataView.frame = viewFrame;
        
        //点击刷新数据
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        tapGr.cancelsTouchesInView = NO;
        [nullDataView addGestureRecognizer:tapGr];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        img.frame = CGRectMake((viewFrame.size.width - img.frame.size.width) / 2.0, 0, 80, 80);
        
        //TODO: 零时设置图片
        [img setImage:[UIImage imageNamed:@"icon_Sad"]];
        [nullDataView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y + 80, nullDataView.frame.size.width, 40)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        label.textColor = RGBColor(0xe8, 0xe8, 0xe8);
        label.textAlignment = NSTextAlignmentCenter;
        if (title.length>0) {
            label.text = title;
        }
        else {
            label.text = @"空空如也,点击刷新";
        }
        
        [nullDataView addSubview:label];
        
        nullDataView.tag = 999;
        [self.view addSubview:nullDataView];
    }
    
    [self.view bringSubviewToFront:nullDataView];
    
    nullDataView.hidden = NO;
}

- (void) isDataNotNull
{
    UIView *nullDataView = [self.view viewWithTag:999];
    nullDataView.hidden = YES;
}

- (void)showWebpage:(NSString *)url
{
    [self showWebpage:url withTitle:nil];
}

- (void)showWebpage:(NSString *)url withTitle:(NSString *)title
{
    if([url rangeOfString:@"www"].location == 0)
    {
        url = [NSString stringWithFormat:@"http://%@", url];
    }
    ISSWebViewController *webViewController = [[ISSWebViewController alloc] init];
    webViewController.url = url;
    if(![SysUtil emptyString:title])
    {
        webViewController.navigationItem.title = title;
    }
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)showAlertDialTelephone:(NSString *)msg withTag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"拨打电话"
                                                        message:[SysUtil emptyString:msg] ? @"" : msg
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"拨打", nil];
    alertView.tag = tag;
    [alertView show];
}

- (void) showHUBMsgTitle:(NSString*)title detail:(NSString*)detail afterDelay:(HUBAferDelay)delay{
    MBProgressHUD *humMsg = [self getHudView];
    humMsg.labelText = title;
    humMsg.detailsLabelText = detail;
    humMsg.mode = MBProgressHUDModeText;
    [self.view addSubview:humMsg];
    [self.view bringSubviewToFront:humMsg];
    [humMsg show:YES];
    [humMsg hide:YES afterDelay:delay*1.0];
}

- (MBProgressHUD *)getHudView
{
    MBProgressHUD *humMsg = [self.view viewWithTag:HUB_VIEW_TAG];
    if (humMsg == nil)
    {
        humMsg = [[MBProgressHUD alloc] initWithView:self.view];
        [humMsg removeFromSuperViewOnHide];
    }
    else
    {
        [humMsg removeFromSuperview];
    }
    return humMsg;
}

- (void) showHUBMsgImgViewMsg:(NSString*)msg afterDelay:(HUBAferDelay)delay {
    [self showHUBMsgImgView:nil msg:msg afterDelay:delay];
}

- (void) showHUBMsgImgView:(NSString*)imgName msg:(NSString*)msg afterDelay:(HUBAferDelay)delay{
    MBProgressHUD *humMsg = [self getHudView];
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    
    NSString* _imgName;
    if (imgName == nil || [imgName isEqualToString:@""]) {
        _imgName = @"icon_sad_white_37";
    }
    else {
        _imgName = imgName;
    }
    [imgView setImage:[UIImage imageNamed:_imgName]];
    humMsg.customView = imgView;
    humMsg.labelText = @"";
    humMsg.detailsLabelText = msg;
    humMsg.mode = MBProgressHUDModeCustomView;
    [self.view addSubview:humMsg];
    [self.view bringSubviewToFront:humMsg];
    [humMsg show:YES];
    [humMsg hide:YES afterDelay:delay*1.0];
}

- (void) showHubMsg:(NSString *)msg
{
    [self showHUBMsgTitle:nil detail:msg afterDelay:2.0];
}

- (void)setHideNavigationBar:(BOOL)hideNavigationBar
{
    objc_setAssociatedObject(self, &hideNavBarKey, [NSString stringWithFormat:@"%zd", hideNavigationBar], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isHideNavigationBar
{
    NSString *str = objc_getAssociatedObject(self, &hideNavBarKey);
    return ![SysUtil emptyString:str] && [str integerValue];
}

- (void) initBackButton
{
    [self initBackButton:@"back.png"];
}

- (void) initBackButton:(NSString *)backImageName
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 32, 32)];
    [leftBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
//    [leftBtn setImage:[[UIImage imageNamed:imageName] rt_tintedImageWithColor:kMenuHilightColor] forState:UIControlStateHighlighted];
    
    if(![SysUtil emptyString:backImageName])
    {
        [leftBtn addTarget:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [space setWidth:-5];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItems = @[space, leftItem];
}

- (void) hideBackButton
{
    [self initBackButton:@""];
}
@end
