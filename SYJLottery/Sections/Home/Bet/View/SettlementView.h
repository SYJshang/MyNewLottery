//
//  SettlementView.h
//  longzhicai
//
//  Created by lili on 2017/4/1.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetModel.h"
@protocol SettlementViewDelegate <NSObject>

/**
 *  代理   点击下注
 */
-(void)clickbetwithmoney:(NSString*)money;

@end

@interface SettlementView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) NSArray           *betArray;   //选择的下注数组
@property (nonatomic, strong)UITextField        *tfmoney;    //购买金额
@property(nonatomic,assign)id<SettlementViewDelegate>delegate;

@property (nonatomic, strong) NSString          *bettype;  //下注类型1  自选下注
@property (nonatomic, strong)UILabel            *lbtotal;          //结算
@property (nonatomic, strong) NSString          *money;  //余额
@property (nonatomic, strong) NSString          *totalmoney;  //共多少钱

-(void)setviewlayoutwithbetarray:(NSArray *)betarray AndBettype:(NSString*)bettype;
-(id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSString          *isguoguan;  //是否是过关



/**
 *   显示列表
 */
-(void)showView;
/**
 *   隐藏
 */
-(void)hiddenView;

@property (nonatomic, strong) NSString          *betnumber;  //注数




@end
