//
//  MyConfig.h
//  bbkm
//
//  Created by liwenzhi on 15/10/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//




#define dUserU                   NSStringFromSelector(@selector(userU))
#define dUserId                  NSStringFromSelector(@selector(userId))
#define dGender                  NSStringFromSelector(@selector(gender))
#define dLoginName               NSStringFromSelector(@selector(loginName))
#define dPassword                NSStringFromSelector(@selector(password))
#define dLogo                    NSStringFromSelector(@selector(logo))
#define dCellPhone               NSStringFromSelector(@selector(cellPhone))
#define dUserName                NSStringFromSelector(@selector(userName))
#define dInviteCode              NSStringFromSelector(@selector(inviteCode))
#define dToken                   NSStringFromSelector(@selector(token))
#define dMoney                   NSStringFromSelector(@selector(money))
#define dDrawMoney               NSStringFromSelector(@selector(drawMoney))
#define dUserBalance             NSStringFromSelector(@selector(userBalance))
#define dShow                    NSStringFromSelector(@selector(show))
#define dIshiddendragbutton      NSStringFromSelector(@selector(ishiddendragbutton))
#define dUnit                    NSStringFromSelector(@selector(unit))
#define dTips                    NSStringFromSelector(@selector(tips))
#define dIsback                  NSStringFromSelector(@selector(isback))
#define dBettype                 NSStringFromSelector(@selector(bettype))
#define dAddress                 NSStringFromSelector(@selector(address))
#define dBbsId                   NSStringFromSelector(@selector(bbsId))
#define dCityId                  NSStringFromSelector(@selector(cityId))
#define dAreaId                  NSStringFromSelector(@selector(areaId))
#define dAddressListArray        NSStringFromSelector(@selector(addressListArray))
#define dIsBindingWeibo          NSStringFromSelector(@selector(isBindingWeibo))
#define dIsBindingWechat         NSStringFromSelector(@selector(isBindingWechat))
#define dIsBindingQQ             NSStringFromSelector(@selector(isBindingQQ))
#define dReceiveNotification     NSStringFromSelector(@selector(receiveNotification))
#define dCityVer                 NSStringFromSelector(@selector(cityVer))
#define dIsUpDataCity            NSStringFromSelector(@selector(isUpDataCity))
#define dProvinceCityTownArray   NSStringFromSelector(@selector(provinceCityTownArray))
#define dGameArray   NSStringFromSelector(@selector(GameArray))




@interface MyConfig : NSObject
{
	NSUserDefaults *defaults;
}

+ (MyConfig *)currentConfig;

@property (readwrite, retain) NSUserDefaults *defaults;

 /**
  *  加密的key
  */
@property (nonatomic, readwrite, retain) NSString            *userU;
/**
 *   用户id
 */
@property (nonatomic, readwrite, retain) NSString            *userId;
 /**
  *  性别
  *  [1.男2.女0.保密]
  */
@property (nonatomic, readwrite, retain) NSString            *gender;
 /**
  *  登录名
  */
@property (nonatomic, readwrite, retain) NSString            *loginName;
/**
 *  登录密码
 */
@property (nonatomic, readwrite, retain) NSString            *password;
 /**
  *  头像
  */
@property (nonatomic, readwrite, retain) NSString            *logo;
 /**
  *  电话
  */
@property (nonatomic, readwrite, retain) NSString            *cellPhone;
 /**
  *  用户昵称
  */
@property (nonatomic, readwrite, retain) NSString            *userName;
/**
 *  邀请码
 */
@property (nonatomic, readwrite, retain) NSString            *inviteCode;
/**
 *  设备码
 */
@property (nonatomic, readwrite, retain) NSString            *token;
 /**
  *  可用余额
  */
@property (nonatomic, readwrite, retain) NSString            *money;
/**
 *  提款金额
 */
@property (nonatomic, readwrite, retain) NSString            *drawMoney;
 /**
  *  今日输赢
  */
@property (nonatomic, readwrite, retain) NSString            *userBalance;
/**
 *  审核控制   1是不显示 0是显示
 */
@property (nonatomic, readwrite, retain) NSString            *show;

 /**
  *  市
  */
@property (nonatomic, readwrite, retain) NSString            *cityId;
 /**
  *  区
  */
@property (nonatomic, readwrite, retain) NSString            *areaId;
/**
 * 接收推送通知
 */
@property (nonatomic, readwrite, retain) NSString            *receiveNotification;

/**
 * 最新城市列表数据版本
 */
@property (nonatomic, readwrite, retain) NSString            *cityVer;
/**
 * 是否更新城市数据版本 0 不更新 1 更新
 */
@property (nonatomic, readwrite, retain) NSString            *isUpDataCity;
/**
 * 省市县数组
 */
@property (nonatomic, readwrite, retain) NSMutableArray      *provinceCityTownArray;
/**
 * 是否是正常的退出登录  2.正常退出登录 退出登陆在我的首页，不返回到首页
 */
@property (nonatomic, readwrite, retain) NSString             *isLoginOutmessage;

/** 
 * 声音提示[1.打开0.关闭] 
 */
@property (nonatomic, readwrite, retain) NSString            *isVoice;
/** 
 * 震动提示[1.打开0.关闭] 
 */
@property (nonatomic, readwrite, retain) NSString            *isVibration;
/**
 * 是否隐藏客服按钮 0 不隐藏 1 隐藏
 */
@property (nonatomic, readwrite, retain) NSString            *ishiddendragbutton;

/**
 * 加载配置，显示单位
 */
@property (nonatomic, readwrite, retain) NSString            *unit;
/**
 * 加载配置，快捷下注提示信息
 */
@property (nonatomic, readwrite, retain) NSString            *tips;
/**
 * 是否从后台切换到前台 0 否 1=三份彩 2=北京赛车 3=幸运28 4=重庆时时彩 5=PC蛋蛋 6=广东快乐10分
 */
@property (nonatomic, readwrite, retain) NSString            *isback;

/**
游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
 */
@property (nonatomic, readwrite, retain) NSString            *bettype;

/**
 * 首页缓存游戏数组
 */
@property (nonatomic, readwrite, retain) NSArray      *GameArray;




@end
