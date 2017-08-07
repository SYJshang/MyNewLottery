//
//  SixBetHeadView.h
//  longzhicai
//
//  Created by lili on 2017/6/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetDetailHeadModel.h"
@protocol SixBetHeadViewDelegate <NSObject>

/**
 *  选择自主下注 快捷下注
 */
-(void)seletebettypewithindex:(int)index;
/**
 *  点击开奖视频
 */

-(void)clicklotteryvideo;
@end


@interface SixBetHeadView : UIView

@property (nonatomic, strong) BetDetailHeadModel *Model;
@property(nonatomic,assign)id<SixBetHeadViewDelegate>delegate;
@property(nonatomic,strong)UILabel   *lbresults;        //开奖结果
@property (nonatomic, strong) NSString       *lotterytype;  //彩票的种类[data.gamelist]游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分


@property (nonatomic, strong) NSString       *bettype;  //是否有快捷下注
@end
