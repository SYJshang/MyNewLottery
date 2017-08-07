//
//  GameListModel.h
//  longzhicai
//
//  Created by lili on 2017/4/5.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameListModel : NSObject
@property (nonatomic, copy) NSString *img;          //[data.gamelist]游戏图片
@property (nonatomic, copy) NSString *type;         //[data.gamelist]游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
@property (nonatomic, copy) NSString *title;              //标题
@property (nonatomic, copy) NSString *subtitle;          //副标题
@end
