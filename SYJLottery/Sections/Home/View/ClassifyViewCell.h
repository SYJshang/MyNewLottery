//
//  ClassifyViewCell.h
//  Money
//
//  Created by mac03 on 2017/3/17.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameListModel.h"
@interface ClassifyViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *img;       //图片
@property (nonatomic, strong) UILabel     *title;     //标题
@property (nonatomic, strong) UILabel     *subtitle;  //副标题
@property (strong, nonatomic) UIView      *line;      //添加line
@property (nonatomic, strong) GameListModel *gameModel;


@end
