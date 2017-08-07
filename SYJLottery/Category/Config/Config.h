//
//  Config.h
//  bbkm
//
//  Created by liwenzhi on 15/10/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//




#define dUserU                   NSStringFromSelector(@selector(userU))
#define dGender                  NSStringFromSelector(@selector(gender))
#define dLoginName               NSStringFromSelector(@selector(loginName))
#define dLogo                    NSStringFromSelector(@selector(logo))
#define dCellPhone               NSStringFromSelector(@selector(cellPhone))
#define dUserName                NSStringFromSelector(@selector(userName))
#define dIsManager               NSStringFromSelector(@selector(isManager))
#define dAddress                 NSStringFromSelector(@selector(address))
#define dBbsId                   NSStringFromSelector(@selector(bbsId))
#define dCityId                  NSStringFromSelector(@selector(cityId))
#define dAreaId                  NSStringFromSelector(@selector(areaId))
#define dIsBindingWeibo          NSStringFromSelector(@selector(isBindingWeibo))
#define dIsBindingWechat         NSStringFromSelector(@selector(isBindingWechat))
#define dIsBindingQQ             NSStringFromSelector(@selector(isBindingQQ))
#define dToken                   NSStringFromSelector(@selector(token))
#define dReceiveNotification                   NSStringFromSelector(@selector(receiveNotification))

@interface Config : NSObject
{
	NSUserDefaults *defaults;
}

+ (Config *)currentConfig;

@property (readwrite, retain) NSUserDefaults *defaults;

 /**
  *  用户u
  */
@property (nonatomic, readwrite, retain) NSString            *userU;
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
  *  头像
  */
@property (nonatomic, readwrite, retain) NSString            *logo;
 /**
  *  电话
  */
@property (nonatomic, readwrite, retain) NSString            *cellPhone;
 /**
  *  用户名
  */
@property (nonatomic, readwrite, retain) NSString            *userName;
 /**
  *  是否是管理员
  *  [0.否1.是]
  */
@property (nonatomic, readwrite, retain) NSString            *isManager;
 /**
  *  城市文字
  */
@property (nonatomic, readwrite, retain) NSString            *address;
 /**
  *  市
  */
@property (nonatomic, readwrite, retain) NSString            *cityId;
 /**
  *  区
  */
@property (nonatomic, readwrite, retain) NSString            *areaId;
/**
 *  圈子id
 */
@property (nonatomic, readwrite, retain) NSString            *bbsId;
 /**
  *  是否绑定了微博
  *  [1.已绑定0.未绑定]
  */
@property (nonatomic, readwrite, retain) NSString            *isBindingWeibo;
 /**
  *  是否绑定了微信
  *  [1.已绑定0.未绑定]
  */
@property (nonatomic, readwrite, retain) NSString            *isBindingWechat;
 /**
  *  是否绑定了QQ
  *  [1.已绑定0.未绑定]
  */
@property (nonatomic, readwrite, retain) NSString            *isBindingQQ;
/**
 *  设备码
 */
@property (nonatomic, readwrite, retain) NSString            *token;
/**
 * 接收推送通知
 */
@property (nonatomic, readwrite, retain) NSString            *receiveNotification;

@end
