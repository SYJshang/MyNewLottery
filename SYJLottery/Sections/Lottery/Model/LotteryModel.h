//
//  LotteryModel.h
//  longzhicai
//
//  Created by lili on 2017/4/12.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryModel : NSObject
@property (nonatomic, copy) NSString *gameName;             //游戏名称
@property (nonatomic, copy) NSString *latestSessionNo;      //[data.items]当前最新期号
@property (nonatomic, copy) NSString *openSessionNo;        //[data.items]开奖的期号
@property (nonatomic, copy) NSArray  *openResult;           //[data.items]开奖的结果，这是一个数组，如果是type=4或者type=2 数组的最后一位是波色 0=无波色 1=绿波 2=蓝波 3=红波
@property (nonatomic, copy) NSString *type;                 //[data.items]游戏类型 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
@property (nonatomic, copy) NSString *time;             //开奖时间
@property (nonatomic, copy) NSString *img;             //

@end
