//
//  BJMovementsView.h
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BJMovementsViewDelegate <NSObject>

/**
 *  代理
 */
//-(void)ShowSontrollerNavigationBar;

@end


@interface BJMovementsView : UIView

@property (nonatomic, strong) NSString       *type;//必选]类型 0=号码 1=大小 2=单双 3=冠亚军和 4=1-5龙虎
@property (nonatomic, assign) int Rightdistance;//视图右边的间距
-(id)initWithRightdistance:(int)rightdistance;

/**
 *   显示列表
 */
-(void)showView;
/**
 *   隐藏
 */
-(void)hiddenView;

@end
