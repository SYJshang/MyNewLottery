//
//  LoopCollectionCell.m
//  Money
//
//  Created by mac03 on 2017/3/16.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "LoopCollectionCell.h"
#import "WJLoopView.h"

@interface LoopCollectionCell ()<WJLoopViewDelegate>


@end


@implementation LoopCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)cellWithArray:(NSArray*)array
{
    _looArray = [array copy];
    NSMutableArray *imgArray = [NSMutableArray array];
//    for (ShufflingModel * model in _looArray) {
//        [imgArray addObject:model.img];
//    }
    _scrollView = [WJLoopView WJLoopViewWithFrame:CGRectMake(0, 0, MSW, MSW/2.0)  delegate:self imageURLs:_looArray placeholderImage:@"dream" timeInterval:5 currentPageIndicatorITintColor:GrayColor pageIndicatorTintColor:[UIColor whiteColor]];
    _scrollView.location = WJPageControlAlignmentCenter;
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_scrollView];
    
}

-(void)WJLoopView:(WJLoopView *)LoopView didClickImageIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchLoopAdverEvent:)]) {
        [_delegate touchLoopAdverEvent:index];
    }
}


@end
