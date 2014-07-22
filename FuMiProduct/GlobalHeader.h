//
//  GlobalHeader.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-1.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#ifndef FuMiProduct_GlobalHeader_h
#define FuMiProduct_GlobalHeader_h


//
@class ProgressHUD;
#import "loginViewController.h"
#import "UIColor+hexStringToColor.h"
#import "CustomSwitch.h"
#import "HttpRequest.h"
#import "BPush.h"
#import "JSONKit.h"
#import "NSString+random.h"
#import "SKSTableView.h"
#import "sksTableview/SKSTableViewCell.h"
#import "ProgressHUD.h"
#import "commonRespondModel.h"
#import "NSString+userName.h"
#import "NSString+dateFormater.h"
#import "PAPasscodeViewController.h"
#import "NSDate+customer.h"
#import "warningNoteViewController/warningNoteViewController.h"

#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define APP_BACKGROUND_COLOR  [UIColor colorWithRed:0 green:222/255.0 blue:111/255.0 alpha:1.0]


//command


//报警电话类型   8
#define AlramPhoneType_OnlyReciveAlarmMsg      @"01"    //只能接收报警信息
#define AlramPhoneType_ControlHost             @"02"    //可远程控制主机


//撤防密码标识  11
#define RetPwdFlag_NoNeedPaswrd     @"00" //撤防不需要密码
#define RetPwdFlag_NeedPaswrd       @"01" //撤防需要密码

#define CHEFANG_PASSWORD_OPEN       @"chefang_password_open"//撤防密码开关

//主机工作状态  12
#define HostWorkSts_LJSF    @"01"       //离家设防(默认)
#define HostWorkSts_ZJSF    @"02"       //在家设防
#define HostWorkSts_CF      @"03"       //撤防

//无线报警设备类型 13
#define AlarmDeviceType_1       @"01"   //门磁
#define AlarmDeviceType_2       @"02"   //烟感
#define AlarmDeviceType_3       @"03"   //红外
#define AlarmDeviceType_4       @"04"   //水侵
#define AlarmDeviceType_5       @"05"   //雾霾
#define AlarmDeviceType_6       @"06"   //幕帘

//无线报警设备警备状态 14
#define AlarmDeviceSts_1        @"00"   //暂时备用
#define AlarmDeviceSts_2        @"01"   //普通警备
#define AlarmDeviceSts_3        @"10"   //24 小时警备
#define AlarmDeviceSts_4        @"11"   //在家模式警备

//操作类别 15
#define OperType_Add        @"01"   //增加
#define OperType_Del        @"02"   //删除
#define OperType_Mof        @"03"   //修改
#define OperType_fid        @"04"   //查询

//重置密码获取验证码标志
#define ResetPswdFlag_Email     @"01"   //主机机主邮箱
#define ResetPswdFlag_Phone     @"02"   //主机手机号码

//login

//#define BASE @"http://qq200824960.eicp.net:53806/EaseHome/door"
//#define BASE @"http://easehome.wicp.net:59943/EaseHome/door"
//#define BASE @"http://zzxkkh.eicp.net:42455/EaseHome/door"
#define BASE @"http://qq200824960.eicp.net:26110/EaseHome/door"
#define KEY_FIRST_USE    @"key_first_use"
#define KEY_USERNAME     @"key_username"
#define KEY_HOSTID       @"key_hostId"

//HTTP
typedef enum _respcodeEnum {
	respcode_Success = 0,
    respcode_ReciveMsg_Failed,  //接收消息失败
    respcode_SendMsg_Failed,
    respcode_GetnewUsrId_Failed,
    respcode_RegistnewUsrId_Failed,
    respcode_ParseJson_Failed,
    respcode_FoxJson_Failed,
    respcode_DeviceId_Existed,
    respcode_DeviceId_Illegal,
    respcode_UsrnameOrPassWord_Error,
    respcode_AlreadyLogin,
    respcode_PhoneNumFormatIllegal,
    respcode_SendMsgFailed,
    respcode_EmailAdr_Illegal,
    
    respcode_unknow = 9999
} respcodeEnum;
//main

#define TAG_LJSF     3000
#define TAG_ZJSF     3001
#define TAG_CF       3002

#define TAG_ALARMTIME     4001
#define TAG_ALARMVOLUME   4002
#define TAG_OUTIN_DELAYTIME    4003


#define TAG_WARNINGNOTE      (4008)
#endif
