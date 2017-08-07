//
//  BetDetailHeadView.h
//  longzhicai
//
//  Created by lili on 2017/3/27.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetDetailHeadModel.h"
@protocol BetDetailHeadViewDelegate <NSObject>

/**
 *  倒计时结束
 */
-(void)Thecountdowntotheend;
@end

@interface BetDetailHeadView : UIView
@property (nonatomic, strong) BetDetailHeadModel *Model;
@property (nonatomic, strong) UILabel     *lblottery;        //彩票房间

@property(nonatomic,assign)id<BetDetailHeadViewDelegate>delegate;
-(void)endtime;

@end
