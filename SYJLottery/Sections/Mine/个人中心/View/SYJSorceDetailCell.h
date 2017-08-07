//
//  SYJSorceDetailCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJSorceDetailModel.h"

@interface SYJSorceDetailCell : UITableViewCell

//typeName = 新用户注册;
//createTime = 2017-07-17 10:10:50;
//scoreDetail = 100;
//mark = 0;

@property (nonatomic, strong) UILabel *typeName;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *scoreLab;

@property (nonatomic, strong) SYJSorceDetailModel *model;


@end
