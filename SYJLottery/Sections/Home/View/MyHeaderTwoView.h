//
//  MyHeaderTwoView.h
//  Money
//
//  Created by mac03 on 2017/3/21.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeaderTwoView : UICollectionReusableView

//添加一个img用于显示图片
@property(nonatomic, strong) UIImageView *img;

//添加一个lable
@property(strong, nonatomic) UILabel *titleLab;

//添加line
@property(strong, nonatomic) UIView *line;

@end
