//
//  BetHeadView.h
//  longzhicai
//
//  Created by lili on 2017/3/29.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetDetailHeadModel.h"

@protocol BetHeadViewDelegate <NSObject>

/**
 *  选择自主下注 快捷下注
 */
-(void)seletebettypewithindex:(int)index;
/**
 *  点击开奖视频
 */

-(void)clicklotteryvideo;
@end

@interface BetHeadView : UIView

@property (nonatomic, strong) BetDetailHeadModel *Model;
@property(nonatomic,assign)id<BetHeadViewDelegate>delegate;
@property(nonatomic,strong)UILabel   *lbresults;        //开奖结果
@property (nonatomic, strong) NSString       *lotterytype;  //彩票的种类[data.gamelist]游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分

@end
