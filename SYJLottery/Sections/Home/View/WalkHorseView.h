//
//  WalkHorseView.h
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WalkHorseViewDelegate <NSObject>

-(void)WalkHorseViewClick:(NSString *)string;

@end
@interface WalkHorseView : UIView<UIScrollViewDelegate>
/** 初始轮播图（推荐使用） */
+ (instancetype)walkHorseLightWithFrame:(CGRect)frame delegate:(id<WalkHorseViewDelegate>)delegate;

+ (instancetype)walkHorseLightWithFrame:(CGRect)frame titleStringsGroup:(NSArray *)titleStringsGroup;

/** 宽度 */
@property (nonatomic,assign) CGFloat labelWidth;

/** 每行高度 */
@property (nonatomic,assign) CGFloat labelHeight;

/** 信息 Warning --- 必须在最后设置数组 */
@property (nonatomic,strong) NSArray * labelTitleArray;

/** 同时显示条数 */
@property (nonatomic,assign) NSInteger  titleCount;

/** 字体颜色 */
@property (nonatomic,strong) UIColor  * textColor;
/** 字体颜色相邻信息的颜色 */
@property (nonatomic,strong) UIColor  * textColor2;


/** 字体大小 */
@property (nonatomic,strong) UIFont  * textFont;

/** 代理点击事件 */
@property (nonatomic,weak)id<WalkHorseViewDelegate> delegate;

/** Block点击事件 */
@property (nonatomic, strong) void(^clickBlock)(NSString * string);


@end
