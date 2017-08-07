//
//  DropDownListView.h
//  longzhicai
//
//  Created by lili on 2017/3/24.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DropDownViewDelegate <NSObject>

/**
 *  代理
 */
-(void)dropDownListParame:(NSString *)aStr;

@end

@interface DropDownListView : UIView
/**
 *  下拉列表
 *  @param array       数据源
 *  @param rowHeight   行高
 *  @param v           控制器>>>可根据需求修改
 */
-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v
                   tophight:(CGFloat)tophight;

/**
 *  设置代理
 */
@property(nonatomic,assign)id<DropDownViewDelegate>delegate;

/**
 *   显示下拉列表
 */
-(void)showList;
/**
 *   隐藏
 */
-(void)hiddenList;

@end
