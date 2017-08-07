//
//  SYJCommentModel.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJCommentModel : NSObject

//content	String	评论内容
//createTime	String	评论时间
//username	String	评论者昵称
//imgPath	String	评论者头像
//userId	Integer	评论者id

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *userId;


@end
