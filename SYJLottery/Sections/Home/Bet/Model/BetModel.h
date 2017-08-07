//
//  BetModel.h
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString         *optionId;  //投注项id
@property (nonatomic, copy) NSString         *title;     //投注项名字
@property (nonatomic, copy) NSString         *rate;      //投注项赔率
@property (nonatomic, copy) NSString         *bettitle;  //下注的名称
@property (nonatomic, copy) NSString         *count;     //用户下注的数量

@end
