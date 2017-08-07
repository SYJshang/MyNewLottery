//
//  SYJUserInfoModel.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJUserInfoModel : NSObject

//userId	Integer	用户id
//username	String	用户名
//imgPath	String	头像url
//earnRate	Integer	盈利率
//buyCount	Integer	购买彩票数
//awardScore	Integer	获得的奖励积分数
//isSign	Integer	用户是否已签到（0：未签，1：已签）
//isBinding	Integer	用户是否绑定真实信息（0：未绑定，1：已绑定）
//inCount	Integer	中奖获得积分数
//score	Integer	总积分数
//payCount	Integer	购买彩票支出积分数
//winCount	Integer	中奖次数
//userSign	String	用户签名
//hitRate	Integer	中奖率
//redCount	Integer	连红数
//levelFlg	Integer	用户等级

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *earnRate;
@property (nonatomic, strong) NSString *buyCount;
@property (nonatomic, strong) NSString *awardScore;
@property (nonatomic, assign) NSInteger isSign;
@property (nonatomic, strong) NSString *inCount;
@property (nonatomic, assign) NSInteger isBinding;
@property (nonatomic, strong) NSString *payCount;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *winCount;
@property (nonatomic, strong) NSString *hitRate;
@property (nonatomic, strong) NSString *redCount;
@property (nonatomic, strong) NSString *levelFlg;
@property (nonatomic, strong) NSString *userSign;





@end
