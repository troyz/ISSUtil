//
//  UIViewController+ISSViewController.h
//  Travel
//
//  Created by 段林波 on 15/4/8.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSHttpClient.h"

typedef NS_ENUM(NSInteger, HUBAferDelay)
{
    HUBAferDelayDefault = 3,
    HUBAferDelay5 = 5,
    HUBAferDelay4 = 4,
    HUBAferDelay2 = 2,
    HUBAferDelay1 = 1
};

@interface UIViewController (ISSUtil)<UIGestureRecognizerDelegate>
- (instancetype)initWithHideNavgationBar:(BOOL)hideNavigationBar;
- (BOOL)isHideNavigationBar;
- (void)setHideNavigationBar:(BOOL)hideNavigationBar;
- (void) startLoading;
- (void) startLoadingFromView:(UIView *)pView;
- (void) startLoadingWithMessage:(NSString *)message;
- (void) startLoadingFromView:(UIView *)pView withMessage:(NSString *)message;
- (void) stopLoading;
- (void) stopLoadingFromView:(UIView *)pView;

/**
 YES: there no error.
 NO: there some error.
 */
- (BOOL) checkHttpError:(ISSHttpError) errorCode;
- (void) initBackButton:(NSString *)backImageName;
- (void) initBackButton;
- (void) hideBackButton;
- (void) backToPre;
- (void) addFirstView;
- (void)showAlert:(NSString *)msg;

// 去掉滑动返回手势
- (void) removePopGuesture;
- (void)setViewInPager:(BOOL)viewInPager;
- (BOOL)isViewInPager;
- (BOOL)isRootViewController;
- (void) isDataNullTarget:(id)target action:(SEL)action;
- (void) isDataNullTarget:(id)target action:(SEL)action title:(NSString*)title;
- (void) isDataNotNull;
- (void)showWebpage:(NSString *)url;
- (void)showWebpage:(NSString *)url withTitle:(NSString *)title;
//拨打电话(代理在自身页面实现)
- (void)showAlertDialTelephone:(NSString *)msg withTag:(NSInteger)tag;

/**
 *  遮罩层提示
 *
 *  @param title  描述
 *  @param detail   详细信息
 *  @param delay    显示时间:(默认3s)
 */
- (void) showHUBMsgTitle:(NSString*)title detail:(NSString*)detail afterDelay:(HUBAferDelay)delay;

/**
 *  遮罩层提示(带表情图标)
 *
 *  @param msg   提示信息
 *  @param delay 显示时间:(默认3s)
 */
- (void) showHUBMsgImgViewMsg:(NSString*)msg afterDelay:(HUBAferDelay)delay;
/**
 *  遮罩层提示(可自定义表情图标)
 *
 *  @param imgName 表情图标名称
 *  @param msg     提示信息
 *  @param delay   显示时间:(默认3s)
 */
- (void) showHUBMsgImgView:(NSString*)imgName msg:(NSString*)msg afterDelay:(HUBAferDelay)delay;
- (void) showHubMsg:(NSString *)msg;
@end
