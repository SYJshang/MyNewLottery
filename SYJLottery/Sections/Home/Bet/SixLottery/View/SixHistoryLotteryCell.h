//
//  SixHistoryLotteryCell.h
//  longzhicai
//
//  Created by lili on 2017/6/6.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryLotteryModel.h"

@interface SixHistoryLotteryCell : UITableViewCell

@property (nonatomic, strong)NSString              *typestr;        //彩票类型
@property (nonatomic, strong)UILabel               *lbtitle;        //彩票名
@property (nonatomic, strong)UILabel               *lbtime;         //揭晓时间
@property (nonatomic, strong)UILabel               *lbtoplift;      //结果总和左上
@property (nonatomic, strong)UILabel               *lbtopright;     //结果右上
@property (nonatomic, strong)UILabel               *lbdownliftone;  //左下第一个
@property (nonatomic, strong)UILabel               *lbdownlifttwo;  //左下第二个
@property (nonatomic, strong)UILabel               *lbdownliftthr;  //左下第三个
@property (nonatomic, strong)UILabel               *lbdownliftfour; //左下第四个
@property (nonatomic, strong)UILabel               *lbdownliftfive; //左下第五个
@property (nonatomic, strong)UILabel               *lbdownliftsix;  //左下第六个


@property (nonatomic, strong)UILabel               *lbdownright;    //右下
@property (nonatomic, strong) HistoryLotteryModel *historylotteryModel;


@end
