//
//  HistoryLotteryModel.h
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryLotteryModel : NSObject
@property (nonatomic, copy) NSString *gameName;         //游戏名称
@property (nonatomic, copy) NSString *openTime;         //开奖时间
@property (nonatomic, copy) NSString *sessionNo;        //期号
@property (nonatomic, copy) NSArray  *resultItems;      //开奖结果数组，字符串数组
@property (nonatomic, copy) NSArray  *sumItems;         //总和结果数组
@property (nonatomic, copy) NSString *longhu;           //龙虎结果，这是一个字符串

@end
