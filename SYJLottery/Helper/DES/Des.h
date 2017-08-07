//
//  Des.h
//  DesDemo
//
//  Created by lili on 2017/5/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Des : NSObject
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+(NSString *) parseByte2HexString:(Byte *) bytes;
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;
+ (NSString *)decryptWithText:(NSString *)sText;//解密


//*************urldecode解码************//
+(NSString *)URLDecodedString:(NSString *)str;
//*************urldecode转码************//
+(NSString*)encodeString:(NSString*)unencodedString;


+ (NSString *)keyValueStringWithDict:(NSDictionary *)dict;

@end
