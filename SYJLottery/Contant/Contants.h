//
//  Contants.h
//  OverSeaOnline
//
//  Created by 健 张 on 14-9-10.
//  Copyright (c) 2014年 jdpay. All rights reserved.
//

#ifndef OverSeaOnline_Contants_h
#define OverSeaOnline_Contants_h

#define IOS10_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS5_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IOS4_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
#define IOS3_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0)


#define IS_IPAD         (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define isIPhone4       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone5       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6p      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//DES加密的密钥
#define DESKEY @"MuNbYnam"
#define DESBUFFER 1024*16


//typedef enum : NSUInteger {
//    FromProduct,
//    FromOrder,
//} FromType;

/*本地化转换*/
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//颜色创建
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]

//安全释放
#define TT_RELEASE_SAFELY(__REF) { (__REF) = nil;}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) { [__REF removeFromSuperview]; __REF = nil; }

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}


#ifdef DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

#define EncodeFormDic(dic,key) [dic[key] isKindOfClass:[NSString class]] ? dic[key] :([dic[key] isKindOfClass:[NSNumber class]] ? [dic[key] stringValue]:@"")

//arc 支持performSelector:
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define MSW ([UIScreen mainScreen].bounds.size.width)
#define MSH ([UIScreen mainScreen].bounds.size.height)

#define screen_width    ([UIScreen mainScreen].bounds.size.width)
#define screen_height   ([UIScreen mainScreen].bounds.size.height)

#define cell_width      self.frame.size.width
#define cell_height     self.frame.size.height

#define DefaultImage3_2  [UIImage imageNamed:@"defaultImage_3.2"]
#define DefaultImage1_3  [UIImage imageNamed:@"defaultImage_1.3"]
#define DefaultImage1_6  [UIImage imageNamed:@"defaultImage_1.6"]
#define DefaultImage1    [UIImage imageNamed:@"defaultImage_1"]
#define DefaultImage2    [UIImage imageNamed:@"defaultImage_2"]
#define DefaultImage3    [UIImage imageNamed:@"defaultImage_3"]
#define DefaultHead      [UIImage imageNamed:@"default_head"]

//字体大小
#define Font11           [UIFont mysystemFontOfSize:11]
#define Font12           [UIFont mysystemFontOfSize:12]
#define Font13           [UIFont mysystemFontOfSize:13]
#define Font14           [UIFont mysystemFontOfSize:14]
#define Font15           [UIFont mysystemFontOfSize:15]
#define Font16           [UIFont mysystemFontOfSize:16]


#define NavColor                  [UIColor colorWithHex:@"#756d67"]    // 导航颜色
#define NavTitleColor             [UIColor colorWithHex:@"#281e1e"]    // 导航栏标题颜色

//#define RedColor                  [UIColor colorWithHex:@"#e72f17"]  //按钮和字体的红色
#define DefaultNoDataImage @"noDataView"            //无数据默认图

#define DefaultImage  @"dream"

#define NetErrorMsg  @"网络连接不可用，请检查是否已联网！"                //网络错误提示


#define BackGroundColor         [UIColor colorWithHex:@"#f0f0f0"]   //控制器背景色
#define BlackTitleColor         [UIColor colorWithHex:@"#281e1e"]   //标题的浅黑色
#define BlackDescColor          [UIColor colorWithHex:@"#999999"]   //描述的浅黑色
#define GrayLightColor          [UIColor colorWithHex:@"#888888"]   //浅黑色（时间等）
#define LineColor               [UIColor colorWithHex:@"#dadada"]   //分割线颜色
#define OrangeGrayColor         [UIColor colorWithHex:@"#fe6c2c"]   //应用内深橘色
#define OrangeLightColor         [UIColor colorWithHex:@"#ffcc33"]    //应用内深橘色
#define SepearGrayLineColor      RGBCOLOR(237, 237, 237)    //应用内分割线颜色
#define DesLightColor            RGBCOLOR(183, 186, 186)    //应用内描述的浅灰色
#define BgColor                   [UIColor colorWithHex:@"#F0F1F2"]    // 浅灰色  背景色
#define BackgroundColor           [UIColor colorWithHex:@"#F0F1F2"]    // 用于UITableView的背景色

#define RedColor                     [UIColor colorWithHex:@"#E7321A"]  //按钮和字体的红色
#define GreenColor                   [UIColor colorWithHex:@"#7FCC20"]  //走势绿色
#define BlueColor                   [UIColor colorWithHex:@"#2F77DA"]  //蓝球颜色
#define GrayColor                   [UIColor colorWithHex:@"#B9B9B9"]  //灰球颜色：


#define BetHeadHight      50     //下注标题的高


#define BigFont 14  //大
#define MiddleFont 12 //中
#define SmallFont 10 //小


#define IPhone4_5_6_6P(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : 0))))

//三个数中最大的
#define MAXThree(a,b,c) (a>b?(a>c?a:c):(b>c?b:c))

//常用颜色
#define MainColor               RGBCOLOR(254, 69, 0)
//为了看控件的位置设置的背景色待数据完整后可设置为透明
#define TestColor               [UIColor clearColor]


//定义极光推送的模式
#ifdef DEBUG
#       define JPushIsProduction 0
#else
#       define JPushIsProduction 1
#endif


//高度自适应
#define MD_MULTILINE_TEXTSIZE(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
//-- MD_MULTILINE_TEXTSIZE_ScrollNavi  字体内容多少判断label的size
#define MD_MULTILINE_TEXTSIZE_ScrollNavi(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;


//自定义某位置的字体大小&颜色&段落样式
#define SetUpTextColorFontParagraph(label,textStr,font,fontRange,color,colorRange,paragraphStyle,paragraphStyleRange,attributedString) \
attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];\
[attributedString addAttribute:NSFontAttributeName value:font range:fontRange];\
[attributedString addAttribute:NSForegroundColorAttributeName value:color range:colorRange];\
[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:paragraphStyleRange];\
label.attributedText = attributedString;


#endif
