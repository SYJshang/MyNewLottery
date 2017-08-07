//
//  PCMovementsView.h
//  longzhicai
//
//  Created by lili on 2017/4/8.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMovementsView : UIView
@property (nonatomic, strong) NSString       *type;//必选]类型 0=号码 1=混合
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