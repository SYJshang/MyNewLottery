//
//  TopTiaoViewCell.h
//  Money
//
//  Created by mac03 on 2017/3/17.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkHorseView.h"

@protocol TopTiaoViewCellDelegate <NSObject>
@end

@interface TopTiaoViewCell : UICollectionViewCell

@property (nonatomic, strong) WalkHorseView *walkhourseview;
@property (nonatomic, strong) NSArray              *titlearray;

@end
