//
//  LotteryViewCell.h
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryModel.h"

@interface LotteryViewCell : UITableViewCell
@property (nonatomic, strong) UILabel               *lbtitle;    //彩票名
@property (nonatomic, strong) UILabel               *lbtime;     //期数
@property (nonatomic, strong) NSString              *typestr;
@property (nonatomic, strong) LotteryModel *Model;

@end
