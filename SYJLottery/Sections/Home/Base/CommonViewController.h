//
//  CommonViewController.h
//  PlanTo
//
//  Created by  zhang jian on 14-3-23.
//  Copyright (c) 2014年 DoubleCat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+ActivityIndicator.h"
#import "AppDelegate.h"
#import "BBTipView.h"
#import "NSTimerHelper.h"
#import "TPKeyboardAvoidingTableView.h"


@interface CommonViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource>  {
    
@protected
    UITableView                             *_tableView;
    
    UITableView                             *_groupTableView;
    
    TPKeyboardAvoidingTableView             *_tpTableView;
    
    NSTimerHelper                           *_dlgTimer;
    
    NSString                                *_pageInTime;
    
    CGFloat                                 mywidth;
    CGFloat                                 myheight;
}

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UITableView       *groupTableView;

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tpTableView;

@property (nonatomic, strong) NSTimerHelper     *dlgTimer;

@property (nonatomic, strong) NSString          *specialViewTitle;

@property (nonatomic, assign) BOOL              isNeedBackItem;//需不需要展示左侧ui,默认为yes展示
@property (nonatomic, assign) BOOL              isNeedBackIcon;
@property (nonatomic, assign) BOOL              isSearchLeftItem;//返回按钮宽度比较小
@property (nonatomic, assign) BOOL              isHasLeftBtn;//有无返回图标，有文字，默认为yes展示返回图标
@property (nonatomic, strong) NSString          *leftTItle;//左侧文字

@property (nonatomic, strong) UIBarButtonItem   *rightBtnItem;

@property (nonatomic, assign) BOOL              hasNav; //default is YES;

@property (nonatomic, assign, getter=isIOS7FullScreenLayout) BOOL  iOS7FullScreenLayout;   //default is NO;
/**  添加返回按钮*/
- (void)addLeftTitle:(BOOL)isHasLeftBtn WithTitle:(NSString*)string WithController:(id)controller;
- (void)addLeftItem;

/**
 *  登录
 */
- (void)goToLogin;

+ (id)controller;

- (void)displayOverFlowActivityView:(NSString *)indiTitle;

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time;

- (void)displayOverFlowActivityView;

- (void)displayOverFlowActivityView:(NSString *)indiTitle yOffset:(CGFloat)y;

- (void)removeOverFlowActivityView;

- (void)successRemoveHUDView;
- (void)timeOutRemoveHUDView;

- (void)presentSheet:(NSString *)indiTitle;
- (void)presentSheet:(NSString *)indiTitle posY:(CGFloat)y;
- (void)presentSheetOnNav:(NSString *)indiTitle;

//添加可展示两行的sheet
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg;
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg posY:(CGFloat)y;


- (void)presentCustomDlg:(NSString *)indiTitle;

- (void)backForePage;//左边item


//工具方法计算visibileRect
- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;


@end