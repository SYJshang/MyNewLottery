//
//  QuickView.h
//  longzhicai
//
//  Created by lili on 2017/3/30.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetModel.h"
@protocol QuickViewDelegate <NSObject>

/**
 *  选择的下注
 */
-(void)seletebetmodelwithmodel:(BetModel*)model Andisselete:(BOOL)isselete;
@end

@interface QuickView : UIView
@property (nonatomic, assign)BOOL           isselete;            //是否选中
@property (nonatomic, strong)UILabel        *lbtitle;            //大小
@property (nonatomic, strong)UILabel        *lbnumber;           //号码

@property (nonatomic, strong) BetModel *Model;

@property(nonatomic,assign)id<QuickViewDelegate>delegate;

@property (nonatomic, assign) int       isRotaryheader;  //是否封盘0 不封 1封盘

@end
