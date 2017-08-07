//
//  SYJForumModle.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJForumModle : NSObject

//title	String	论坛标题
//content	String	论坛内容
//forumId	Integer	论坛id
//createTime	String	论坛发表时间
//userId	Integer	论坛作者Id
//username	String	论坛作者昵称
//readCount	Integer	阅读数
//imgPath	String	论坛作者头像
//hitTotal	Integer	点赞数
//commentCount	Integer	评论数
//isThumb	Integer	该论坛用户是否点过赞（0：未赞，1：已赞）
//isCollection	Integer	该论坛用户是否收藏过（0：未收藏，2：已收藏）
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *hitTotal;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, assign) NSInteger isThumb;
@property (nonatomic, assign) NSInteger isCollection;




@end
