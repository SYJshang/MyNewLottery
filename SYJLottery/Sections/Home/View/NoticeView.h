//
//  NoticeView.h
//  longzhicai
//
//  Created by lili on 2017/5/5.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkHorseView.h"

@protocol NoticeViewDelegate <NSObject>

- (void)clicknotieindex:(NSInteger)index;

@end
@interface NoticeView : UICollectionReusableView
@property (nonatomic,strong) id <NoticeViewDelegate> delegate;
@property (nonatomic, strong) NSArray              *NoticeArray;
@property (nonatomic, strong) WalkHorseView *walkhourseview;

@end
