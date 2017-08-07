//
//  BetTypeHeadView.h
//  longzhicai
//
//  Created by lili on 2017/3/29.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BetTypeHeadViewDelegate <NSObject>

/**
 *  代理
 */
-(void)clickviewwithtag:(int)tag isopen:(BOOL)isopen;

@end

@interface BetTypeHeadView : UIView


@property (nonatomic, assign) BOOL isopen;            //是否展开
@property (nonatomic, strong) NSArray  *titleArray;   //标题数组
@property (nonatomic, assign) int viewtag;            //view的标签
@property(nonatomic,assign)id<BetTypeHeadViewDelegate>delegate;

@end
