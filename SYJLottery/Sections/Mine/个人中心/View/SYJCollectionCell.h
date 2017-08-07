//
//  SYJCollectionCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetModel.h"

@interface SYJCollectionCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;     //投注项名字
@property (nonatomic, strong) UILabel *rateLab;      //投注项赔率
@property (nonatomic, strong) UILabel *bettitleLab;  //下注的名称
@property (nonatomic, strong) UILabel *countLab;     //用户下注的数量

@property (nonatomic, strong) BetModel *model;

@end
