//
//  RankingModel.h
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingModel : NSObject
@property (nonatomic, copy) NSString *title;      //[data.items]类型名称 如：第2名 大
@property (nonatomic, copy) NSString *num;        //连续的期数

@end
