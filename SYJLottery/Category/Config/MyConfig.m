//
//  MyConfig.m
//  bbkm
//
//  Created by liwenzhi on 15/10/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "MyConfig.h"

@implementation MyConfig

@synthesize defaults;
@dynamic userU;
@dynamic userId;
@dynamic gender;
@dynamic loginName;
@dynamic password;
@dynamic logo;
@dynamic cellPhone;
@dynamic userName;
@dynamic inviteCode;
@dynamic token;
@dynamic money;
@dynamic userBalance;
@dynamic drawMoney;
@dynamic show;
@dynamic ishiddendragbutton;
@dynamic unit;
@dynamic tips;
@dynamic isback;
@dynamic bettype;
@dynamic cityId;
@dynamic areaId;
@dynamic receiveNotification;
@dynamic cityVer;
@dynamic isUpDataCity;



-(id) init {
	
    if(!(self = [super init]))
        return self;
    
    self.defaults = [NSUserDefaults standardUserDefaults];

    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                     @"",                               dUserU,
                                     @"",                               dUserId,
                                     @"",                               dGender,
                                     @"",                               dLoginName,
                                     @"",                               dPassword,
                                     @"",                               dLogo,
                                     @"",                               dCellPhone,
                                     @"",                               dUserName,
                                     @"",                               dInviteCode,
                                     @"",                               dMoney,
                                     @"",                               dDrawMoney,
                                     @"",                               dUserBalance,
                                     @"",                               dShow,
                                     @"",                               dToken,
                                     @"",                               dIshiddendragbutton,
                                     @"",                               dTips,
                                     @"",                               dIsback,
                                     @"",                               dBettype,
                                     @"",                               dAddress,
                                     @"",                               dCityId,
                                     @"",                               dAreaId,
                                     @"",                               dReceiveNotification,
                                     @"",                               dCityVer,
                                     @"",                               dIsUpDataCity,
                                    nil]];
	return self;
}

-(void) dealloc
{
    self.defaults = nil;
    self.userU = nil;
    self.userId = nil;
    self.gender = nil;
    self.loginName = nil;
    self.password = nil;
    self.logo = nil;
    self.cellPhone = nil;
    self.userName = nil;
    self.inviteCode = nil;
    self.token = nil;
    self.money = nil;
    self.drawMoney = nil;
    self.userBalance = nil;
    self.show = nil;
    self.bettype=nil;
    self.ishiddendragbutton=nil;
    self.tips=nil;
    self.isback=nil;
    self.unit=nil;
    self.cityId = nil;
    self.areaId = nil;
    self.receiveNotification = nil;
    self.cityVer = nil;
    self.isUpDataCity = nil;

}

+(MyConfig *) currentConfig {
    
    static MyConfig *instance;
	
    if(!instance)
		
        instance = [[MyConfig alloc] init];
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	
    
    
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"]){
		
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
    //DLog(@"methodSignatureForSelector 2\n");
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSString *selector = NSStringFromSelector(anInvocation.selector);
    if ([selector hasPrefix:@"set"]) {
        NSRange firstChar, rest;
        firstChar.location  = 3;
        firstChar.length    = 1;
        rest.location       = 4;
        rest.length         = selector.length - 5;
        
        selector = [NSString stringWithFormat:@"%@%@",
                    [[selector substringWithRange:firstChar] lowercaseString],
                    [selector substringWithRange:rest]];
        
        __unsafe_unretained id value;
        [anInvocation getArgument:&value atIndex:2];
		
		//DLog(@"forwardInvocation 1\n");
        
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
        
    }
    
    else {
		//DLog(@"forwardInvocation 2\n");
        id value = [self.defaults objectForKey:selector];
        
        if ([value isKindOfClass:[NSData class]])
        {
            void *cfValue = (__bridge void *)[NSKeyedUnarchiver unarchiveObjectWithData:value];
            [anInvocation setReturnValue:&cfValue];
        }
        else
        {
            [anInvocation setReturnValue:&value];
        }
        
    }
}

//-(NSMutableArray *)addressListArray {
//    if (!_addressListArray) {
//        _addressListArray = [NSMutableArray new];
//    }
//    return _addressListArray;
//}

@end
