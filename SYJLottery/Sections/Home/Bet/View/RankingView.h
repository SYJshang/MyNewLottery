//
//  RankingView.h
//  longzhicai
//
//  Created by lili on 2017/3/28.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingModel.h"
@interface RankingView : UIView
@property (nonatomic, strong) NSMutableArray           *dataArray;   //排行数组
@property (nonatomic, assign) int Rightdistance;              //视图右边的间距
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
