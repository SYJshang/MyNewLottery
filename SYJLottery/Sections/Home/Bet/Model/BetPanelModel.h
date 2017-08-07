//
//  BetPanelModel.h
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetPanelModel : NSObject
@property (nonatomic, copy) NSString         *optionTitle;      //投注类型名称，如冠军
@property (nonatomic, strong) NSArray        *optionItems;        //optionItems
@property (nonatomic, copy) NSString         *optionType;      //投注类型名称，如冠军


@end
