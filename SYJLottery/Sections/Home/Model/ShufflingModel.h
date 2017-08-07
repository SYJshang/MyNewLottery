//
//  ShufflingModel.h
//  longzhicai
//
//  Created by lili on 2017/3/22.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShufflingModel : NSObject
@property (nonatomic, copy) NSString *title;        //[data]数据集合
@property (nonatomic, copy) NSString *items;        //[data]数据集合
@property (nonatomic, copy) NSString *type;         //[data.items]广告类型[ 2.网页]
@property (nonatomic, copy) NSString *img;          //[data.items]图片[宽/高=3.2][640x200]
@property (nonatomic, copy) NSString *link;         //[data.items]链接地址，type=2时用到
@end
