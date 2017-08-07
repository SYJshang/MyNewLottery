//
//  SYJNewsCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJNewsModel.h"

@interface SYJNewsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *readCountLab;
@property (nonatomic, strong) UILabel *newsTypeLab;
//@property (nonatomic, strong) UILabel *dianzanCountLab;
//@property (nonatomic, strong) UILabel *commnetLab;

@property (nonatomic, strong) SYJNewsModel *model;



@end
