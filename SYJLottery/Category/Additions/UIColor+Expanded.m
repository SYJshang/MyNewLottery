//
//  UIColor+Expanded.m
//  GQ_IOS_MobileHospital
//
//  Created by Mengying Xu on 14-6-19.
//  Copyright (c) 2014年 Gary. All rights reserved.
//

#import "UIColor+Expanded.h"

@implementation UIColor (Expanded)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

@end
