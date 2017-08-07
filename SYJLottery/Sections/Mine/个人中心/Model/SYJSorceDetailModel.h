//
//  SYJSorceDetailModel.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJSorceDetailModel : NSObject

//typeName = 新用户注册;
//createTime = 2017-07-17 10:10:50;
//scoreDetail = 100;
//mark = 0;

@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *scoreDetail;
@property (nonatomic, assign) NSInteger mark;


@end
