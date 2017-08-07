//
//  SYJCommentCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJCommentModel.h"

@interface SYJCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, strong) SYJCommentModel *model;


@end
