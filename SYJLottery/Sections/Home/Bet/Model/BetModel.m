//
//  BetModel.m
//  longzhicai
//
//  Created by lili on 2017/4/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetModel.h"

@implementation BetModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.optionId forKey:@"optionId"];
    [aCoder encodeObject:self.rate forKey:@"rate"];
    [aCoder encodeObject:self.bettitle forKey:@"bettitle"];
    [aCoder encodeObject:self.count forKey:@"count"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.optionId = [aDecoder decodeObjectForKey:@"optionId"];
        self.rate = [aDecoder decodeObjectForKey:@"rate"];
        self.bettitle = [aDecoder decodeObjectForKey:@"bettitle"];
        self.count = [aDecoder decodeObjectForKey:@"count"];

    }
    return self;
}

@end
