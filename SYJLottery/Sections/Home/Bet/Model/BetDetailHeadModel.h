//
//  BetDetailHeadModel.h
//  longzhicai
//
//  Created by lili on 2017/4/6.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetDetailHeadModel : NSObject
@property (nonatomic, copy) NSString *gains;            //当前收益
@property (nonatomic, copy) NSString *gameName;         //游戏名字
@property (nonatomic, copy) NSString *room;             //房间号
@property (nonatomic, copy) NSString *sessionNo;        //当前期号
@property (nonatomic, copy) NSString *openDate;         //开奖时间
@property (nonatomic, copy) NSString *betTime;          //截止投注时间，单位秒
@property (nonatomic, copy) NSString *openTime;         //距离当前期开奖时间，单位秒
@property (nonatomic, copy) NSString *lastSessionNo;    //上期开奖号
@property (nonatomic, copy) NSArray  *openResult;       //上期开奖结果，字符串数组
@property (nonatomic, copy) NSString *money;            //余额

@end
