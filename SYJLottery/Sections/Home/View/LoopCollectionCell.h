//
//  LoopCollectionCell.h
//  Money
//
//  Created by mac03 on 2017/3/16.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLoopView.h"
#import "ShufflingModel.h"

@protocol loopCollectionDelegate <NSObject>

- (void)touchLoopAdverEvent:(NSInteger)index;

@end
@interface LoopCollectionCell : UICollectionViewCell

@property (nonatomic,strong) id <loopCollectionDelegate> delegate;
@property (nonatomic, strong) WJLoopView           *scrollView;    //轮播
@property (nonatomic, strong) NSArray              *looArray;

- (void)cellWithArray:(NSArray*)array;

@end
