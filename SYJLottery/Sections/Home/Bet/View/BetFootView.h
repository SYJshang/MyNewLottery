//
//  BetFootView.h
//  longzhicai
//
//  Created by lili on 2017/3/27.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BetFootViewDelegate <NSObject>

/**
 *  代理
 */
-(void)clickwithbuttontag:(int)tag;

@end


@interface BetFootView : UIView

@property(nonatomic,assign)id<BetFootViewDelegate>delegate;

@end
