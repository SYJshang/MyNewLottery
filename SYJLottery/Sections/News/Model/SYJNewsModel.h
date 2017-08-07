//
//  SYJNewsModel.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJNewsModel : NSObject

//title	String	资讯标题
//newsId	Integer	资讯Id
//readCount	Integer	阅读数
//registertime	String	资讯发布时间
//newsContent	String	资讯内容
//typeId	Integer	资讯类型id
//newsType	String	资讯类型
//commentCount	Integer	评论总数
//imageurl	String	资讯图片url
//isHit	String	当前用户是否点赞（0：未赞，1：已赞）
//totalHit	Integer	点赞数

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *registertime;
@property (nonatomic, strong) NSString *newsContent;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *newsType;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, assign) NSInteger isHit;
@property (nonatomic, strong) NSString *totalHit;



@end
