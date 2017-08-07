//
//  NoticeView.m
//  longzhicai
//
//  Created by lili on 2017/5/5.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "NoticeView.h"
#import "UIColor+Wonderful.h"
#import "SXMarquee.h"
#import "SXHeadLine.h"
#import "ShufflingModel.h"
//#import "SDCycleScrollView.h"

@interface NoticeView ()
{
    UIImageView*_imgnotice;
    SXHeadLine *_headLine;
//    SDCycleScrollView *_cycleScrollView;
}
@end
@implementation NoticeView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _imgnotice = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 23, 20)];
        _imgnotice.image=[UIImage imageNamed:@"公告"];
        [self addSubview:_imgnotice];
        
        UIView*grayview=[[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-10, MSW, 10)];
        grayview.backgroundColor=BackGroundColor;
        [self addSubview:grayview];
        
    }
    return self;
}

-(void)setNoticeArray:(NSArray *)NoticeArray{
    NSMutableArray *titleArray = [NSMutableArray array];
//            for (ShufflingModel * model in NoticeArray) {
//                DLog(@"-=-=----%@",model.title);
//                [titleArray addObject:model.title];
//            }
    
    titleArray = [NoticeArray mutableCopy];

    
    if (!_headLine&&NoticeArray.count>0) {
//
        _headLine = [[SXHeadLine alloc]initWithFrame:CGRectMake(_imgnotice.right+10, 0, MSW-60, 40)];
        _headLine.messageArray =titleArray;
        [_headLine setBgColor:[UIColor whiteColor] textColor:BlackTitleColor textFont:[UIFont systemFontOfSize:13]];
        [_headLine setScrollDuration:0.5 stayDuration:3];
        _headLine.hasGradient = YES;
        
        [_headLine changeTapMarqueeAction:^(NSInteger index) {
//            NSLog(@"你点击了第 %ld 个button！内容：%@", index, _headLine.messageArray[index]);
            [self.delegate clicknotieindex:index];
        }];
        [_headLine start];
        
        [self addSubview:_headLine];
    }
    
//        if (!_cycleScrollView&&NoticeArray.count>0) {
//   _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(_imgnotice.right+10, 0,  MSW-60, 40) delegate:self placeholderImage:nil];
//    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _cycleScrollView.onlyDisplayText = YES;
//    _cycleScrollView.titleLabelBackgroundColor=[UIColor whiteColor];
//    _cycleScrollView.titleLabelTextColor=BlackTitleColor;
//    _cycleScrollView.autoScrollTimeInterval=3;
//    _cycleScrollView.titleLabelTextFont=[UIFont mysystemFontOfSize:13];
//    _cycleScrollView.titlesGroup = [titleArray copy];
//    [self addSubview:_cycleScrollView];
//    }
}

#pragma mark - SDCycleScrollViewDelegate

//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//                [self.delegate clicknotieindex:index];
//    
//}

@end
