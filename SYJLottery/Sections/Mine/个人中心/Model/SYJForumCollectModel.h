//
//  SYJForumCollectModel.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJForumCollectModel : NSObject

//title	String	论坛标题
//content	String	论坛内容
//createTime	String	论坛发表时间
//forumId	Integer	论坛Id
//readCount	Integer	阅读数
//imgPath	String	论坛作者头像
//authorName	String	论坛作者名
//isThumb	Integer	当前用户是否赞过改论坛（0：未赞，1：已赞）
//commentCount	Integer	论坛评论总数
//hitTotal	Integer	论坛点赞总数
//authorId	Integer	论坛作者id

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, assign) NSInteger isThumb;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *hitTotal;
@property (nonatomic, strong) NSString *authorId;


@end
