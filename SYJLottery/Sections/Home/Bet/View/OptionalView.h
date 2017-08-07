//
//  OptionalView.h
//  longzhicai
//
//  Created by lili on 2017/3/30.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetModel.h"
@protocol OptionalViewDelegate <NSObject>

/**
 *  选择的下注
 */
-(void)seletebetmodelwithmodel:(BetModel*)model;
@end

@interface OptionalView : UIView<UITextFieldDelegate>
@property (nonatomic, strong)UILabel               *lbtitle;
@property (nonatomic, strong)UITextField           *tfnumber;
@property (nonatomic, strong) BetModel *Model;
@property (nonatomic, strong) NSString       *bettype;  //下注类型
@property (nonatomic, assign) int       isRotaryheader;  //是否封盘0 不封 1封盘


@property(nonatomic,assign)id<OptionalViewDelegate>delegate;


@end
