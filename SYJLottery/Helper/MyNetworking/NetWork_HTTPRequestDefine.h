//
//  NetWork_HTTPRequestDefine.h
//  longzhicai
//
//  Created by 夏云飞 on 2017/2/14.
//  Copyright © 2017年 xyf. All rights reserved.
//

#ifndef NetWork_HTTPRequestDefine_h
#define NetWork_HTTPRequestDefine_h

//#define SERVER       @"http://api.suredbits.com/"         // 正式服务器
#define SERVER       @"http://longzhicai.boguyuan.com/longzhicai/"         // 测试服务器
#define SERVERURL    [NSString stringWithFormat:@"%@api/",SERVER]
//#define SERVERURL    [NSString stringWithFormat:@"%@",SERVER]

// **********************   首页  **********************
#define HTTP_home_advert               @"baseData_advert"           // 1.1 首页轮播
#define HTTP_home_gameColumn           @"baseData_gameColumn"       // 1.2 首页游戏列表
#define HTTP_home_winList              @"baseData_winList"          // 1.3 最新中奖
#define HTTP_sms_send                  @"sms_send"                  // 1.4  发送短信
#define HTTP_baseData_aboutus          @"baseData_aboutus"          // 1.5  关于我们
#define HTTP_baseData_checkVer         @"baseData_checkVer"         // 1.6  版本更新
#define HTTP_baseData_latestList       @"baseData_latestList"       // 1.7  彩种和开奖接口
#define HTTP_baseData_money            @"baseData_money"            // 1.8  用户最新余额
#define HTTP_baseData_question         @"baseData_question"         // 1.10常见问题
#define HTTP_baseData_activitie        @"baseData_activitie"        // 1.11优惠活动
#define HTTP_baseData_share            @"baseData_share"            // 1.12  分享
#define HTTP_baseData_privacy          @"baseData_privacy"          // 1.13隐私政策
#define HTTP_baseData_apprenticelist   @"baseData_apprenticelist"   // 1.14徒弟列表
#define HTTP_baseData_terms            @"baseData_terms"            // 1.15服务协议
#define HTTP_baseData_loadConfig       @"baseData_loadConfig"       // 1.17 加载配置，隐藏功能
#define HTTP_baseData_unit             @"baseData_unit"             // 1.18 显示单位
#define HTTP_baseData_tips             @"baseData_tips"             // 1.19 快捷下注提示信息
#define HTTP_baseData_notice           @"baseData_notice"           // 1.21首页通知



// **********************   2北京三分彩  **********************
#define HTTP_bj3_currentTime           @"bj3_currentTime"         //2.1当前期的信息
#define HTTP_bj3_betPane               @"bj3_betPanel"            //2.2投注面板信息
#define HTTP_bj3_bet                   @"bj3_bet"                 //2.3投注接口
#define HTTP_bj3_hotRanking            @"bj3_hotRanking"          //2.4冷热排行
#define HTTP_bj3_trend                 @"bj3_trend"               //2.5走势
#define HTTP_bj3_rules                 @"bj3_rules"               //2.6游戏规则
#define HTTP_bj3_openList              @"bj3_openList"            //2.7历史开奖记录
#define HTTP_Test_List                 @"nba/v0/players/cle"            //测试

// **********************   3北京赛车  **********************
#define HTTP_bjPk10_currentTime         @"bjPk10_currentTime"    //3.2当前期的信息
#define HTTP_bjPk10_betPanel            @"bjPk10_betPanel"       //3.3投注面板信息
#define HTTP_bjPk10_bet                 @"bjPk10_bet"            //3.4投注接口
#define HTTP_bjPk10_hotRanking          @"bjPk10_hotRanking"     //3.5冷热排行
#define HTTP_bjPk10_trend               @"bjPk10_trend"          //3.6走势
#define HTTP_bjPk10_rules               @"bjPk10_rules"          //3.7游戏规则
#define HTTP_bjPk10_openList            @"bjPk10_openList"       //3.8历史开奖记录
// **********************   4PC蛋蛋(北京幸运28)  **********************
#define HTTP_bjLu28_currentTime         @"bjLu28_currentTime"         //4.1当前期的信息
#define HTTP_bjLu28_betPanel            @"bjLu28_betPanel"            //4.2投注面板信息
#define HTTP_bjLu28_bet                 @"bjLu28_bet"                 //4.3投注接口
#define HTTP_bjLu28_hotRanking          @"bjLu28_hotRanking"          //4.4冷热排行
#define HTTP_bjLu28_trend               @"bjLu28_trend"               //4.5走势
#define HTTP_bjLu28_rules               @"bjLu28_rules"               //4.6游戏规则
#define HTTP_bjLu28_openList            @"bjLu28_openList"            //4.7历史开奖记录
// **********************   5幸运28(新加坡28)  **********************
#define HTTP_xjpLu28_currentTime         @"xjpLu28_currentTime"         //5.1当前期的信息
#define HTTP_xjpLu28_betPanel            @"xjpLu28_betPanel"            //5.2投注面板信息
#define HTTP_xjpLu28_bet                 @"xjpLu28_bet"                 //5.3投注接口
#define HTTP_xjpLu28_hotRankingg         @"xjpLu28_hotRanking"          //5.4冷热排行
#define HTTP_xjpLu28_trend               @"xjpLu28_trend"               //5.5走势
#define HTTP_xjpLu28_rules               @"xjpLu28_rules"               //5.6游戏规则
#define HTTP_xjpLu28_openList            @"xjpLu28_openList"            //5.7历史开奖记录
// **********************  广东快乐十分  **********************
#define HTTP_gdk10_currentTime         @"gdK10_currentTime"         //6.1当前期的信息
#define HTTP_gdk10_betPanel            @"gdK10_betPanel"            //6.2投注面板信息
#define HTTP_gdk10_bet                 @"gdK10_bet"                 //6.3投注接口
#define HTTP_gdk10_hotRanking          @"gdK10_hotRanking"          //6.4冷热排行
#define HTTP_gdk10_trend               @"gdK10_trend"               //6.5走势
#define HTTP_gdk10_rules               @"gdK10_rules"               //6.6游戏规则
#define HTTP_gdk10_openList            @"gdK10_openList"            //6.7历史开奖记录
// **********************  重庆时时彩  **********************
#define HTTP_cqSsc_currentTime         @"cqSsc_currentTime"         //7.1当前期的信息
#define HTTP_cqSsc_betPanel            @"cqSsc_betPanel"            //7.2投注面板信息
#define HTTP_cqSSc_bet                 @"cqSsc_bet"                 //7.3投注接口
#define HTTP_cqSSc_hotRanking          @"cqSsc_hotRanking"          //7.4冷热排行
#define HTTP_cqSSc_trend               @"cqSsc_trend"               //7.5走势
#define HTTP_cqSSc_rules               @"cqSsc_rules"               //7.6游戏规则
#define HTTP_cqSSc_openList            @"cqSsc_openList"            //7.7历史开奖记录
// **********************  快乐扑克3  **********************
#define HTTP_poker_currentTime         @"poker_currentTime"         //8.1当前期的信息
#define HTTP_poker_betPanel            @"poker_betPanel"            //8.2投注面板信息
#define HTTP_poker_bet                 @"poker_bet"                 //8.3投注接口
#define HTTP_poker_hotRanking          @"poker_hotRanking"          //8.4冷热排行
#define HTTP_poker_trend               @"poker_trend"               //8.5走势
#define HTTP_poker_rules               @"poker_rules"               //8.6游戏规则
#define HTTP_poker_openList            @"poker_openList"            //8.7历史开奖记录

// **********************  天津时时彩  **********************
#define HTTP_tjSsc_currentTime         @"tjSsc_currentTime"         //7.1当前期的信息
#define HTTP_tjSsc_betPanel            @"tjSsc_betPanel"            //7.2投注面板信息
#define HTTP_tjSsc_bet                 @"tjSsc_bet"                 //7.3投注接口
#define HTTP_tjSsc_hotRanking          @"tjSsc_hotRanking"          //7.4冷热排行
#define HTTP_tjSsc_trend               @"tjSsc_trend"               //7.5走势
#define HTTP_tjSsc_rules               @"tjSsc_rules"               //7.6游戏规则
#define HTTP_tjSsc_openList            @"tjSsc_openList"            //7.7历史开奖记录

// **********************  新疆时时彩  **********************
#define HTTP_xjSsc_currentTime         @"xjSsc_currentTime"         //7.1当前期的信息
#define HTTP_xjSsc_betPanel            @"xjSsc_betPanel"            //7.2投注面板信息
#define HTTP_xjSsc_bet                 @"xjSsc_bet"                 //7.3投注接口
#define HTTP_xjSsc_hotRanking          @"xjSsc_hotRanking"          //7.4冷热排行
#define HTTP_xjSsc_trend               @"xjSsc_trend"               //7.5走势
#define HTTP_xjSsc_rules               @"xjSsc_rules"               //7.6游戏规则
#define HTTP_xjSsc_openList            @"xjSsc_openList"            //7.7历史开奖记录

// **********************  广东11选5  **********************
#define HTTP_gdPick11_currentTime         @"gdPick11_currentTime"         //7.1当前期的信息
#define HTTP_gdPick11_betPanel            @"gdPick11_betPanel"            //7.2投注面板信息
#define HTTP_gdPick11_bet                 @"gdPick11_bet"                 //7.3投注接口
#define HTTP_gdPick11_hotRanking          @"gdPick11_hotRanking"          //7.4冷热排行
#define HTTP_gdPick11_trend               @"gdPick11_trend"               //7.5走势
#define HTTP_gdPick11_rules               @"gdPick11_rules"               //7.6游戏规则
#define HTTP_gdPick11_openList            @"gdPick11_openList"            //7.7历史开奖记录

// **********************  江苏快3  **********************
#define HTTP_jsK3_currentTime         @"jsK3_currentTime"         //7.1当前期的信息
#define HTTP_jsK3_betPanel            @"jsK3_betPanel"            //7.2投注面板信息
#define HTTP_jsK3_bet                 @"jsK3_bet"                 //7.3投注接口
#define HTTP_jsK3_hotRanking          @"jsK3_hotRanking"          //7.4冷热排行
#define HTTP_jsK3_trend               @"jsK3_trend"               //7.5走势
#define HTTP_jsK3_rules               @"jsK3_rules"               //7.6游戏规则
#define HTTP_jsK3_openList            @"jsK3_openList"            //7.7历史开奖记录
// **********************  广西快乐十分  **********************
#define HTTP_gxK10_currentTime         @"gxK10_currentTime"         //7.1当前期的信息
#define HTTP_gxK10_betPanel            @"gxK10_betPanel"            //7.2投注面板信息
#define HTTP_gxK10_bet                 @"gxK10_bet"                 //7.3投注接口
#define HTTP_gxK10_hotRanking          @"gxK10_hotRanking"          //7.4冷热排行
#define HTTP_gxK10_trend               @"gxK10_trend"               //7.5走势
#define HTTP_gxK10_rules               @"gxK10_rules"               //7.6游戏规则
#define HTTP_gxK10_openList            @"gxK10_openList"            //7.7历史开奖记录
// **********************  六合彩  **********************
#define HTTP_markSix_currentTime         @"markSix_currentTime"         //7.1当前期的信息
#define HTTP_markSix_betPanel            @"markSix_betPanel"            //7.2投注面板信息
#define HTTP_markSix_bet                 @"markSix_bet"                 //7.3投注接口
#define HTTP_markSix_hotRanking          @"markSix_hotRanking"          //7.4冷热排行
#define HTTP_markSix_trend               @"markSix_trend"               //7.5走势
#define HTTP_markSix_rules               @"markSix_rules"               //7.6游戏规则
#define HTTP_markSix_openList            @"markSix_openList"            //7.7历史开奖记录
#define HTTP_markSix_combinaInfo         @"markSix_combinaInfo"        //11.6排列组合



// **********************  用户  **********************

#define HTTP_user_reg                 @"user_reg"           // 2.1  注册
#define HTTP_user_login               @"user_login"         // 2.2  登录
#define HTTP_user_logout              @"user_logout"        // 2.3  退出登录
#define HTTP_user_changePwd           @"user_changePwd"     // 2.4  修改密码
#define HTTP_user_cashPassword        @"user_cashPassword"  // 2.5设置提现密码
#define HTTP_user_retrievePwd         @"user_retrievePwd"   // 2.6找回密码
#define HTTP_user_head                @"user_head"          // 2.7上传头像
#define HTTP_user_save                @"user_save"          // 2.8保存用户信息
// **********************   我的  **********************

#define HTTP_baseData_betlist          @"baseData_betlist"           // 1.9  投注记录
#define HTTP_baseData_winninglist      @"baseData_winninglist"       // 1.20 中奖纪录
#define HTTP_recharge_detail           @"recharge_detail"            // 9.1  充值记录
#define HTTP_recharge_list             @"recharge_list"              // 9.2充值金额列表
#define HTTP_recharge_submit           @"recharge_submit"            // 9.3提交充值
#define HTTP_baseData_bankMsg          @"baseData_bankMsg"           // 9.4线下充值银行卡列表 及账户信息
#define HTTP_recharge_offlineSubmit    @"recharge_offlineSubmit"     // 9.5线下充值提交


// **********************   提现充值  **********************
#define HTTP_cash_submit              @"cash_submit"        //10.1提现提交
#define HTTP_cash_list                @"cash_list"          //10.2提现记录
#define HTTP_cash_bankList            @"cash_bankList"      //10.3提现方式及银行选择
#define HTTP_baseData_list3           @"baseData_list3"     //10.4提现省市区三级联动













#endif /* NetWork_HTTPRequestDefine_h */
