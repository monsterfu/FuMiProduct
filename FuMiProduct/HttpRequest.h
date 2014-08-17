//
//  HttpRequest.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "alarmTelephoneModel.h"
#import "rfidDeviceModel.h"
#import "wirelessAlarmDeviceModel.h"
#import "alarmMessageModel.h"
@interface HttpRequest : NSObject



+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)fetchHostRequest:(NSString*)mobile seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)LoginRequest:(NSString*)mobile password:(NSString*)password hostId:(NSString*)hostid seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)proportySetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno name:(NSString*)name email:(NSString*)email question:(NSString*)question answer:(NSString*)answer workstatus:(NSString*)workstatus rspdelay:(NSString*)rspdelay almvolume:(NSString*)almvolume alarmtime:(NSString*)alarmtime retpwdflag:(NSString*)retpwdflag onekeyphone:(NSString*)onekeyphone address:(NSString*)address delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel tag:(NSUInteger)tag;

+(void)addAlarmphoneNumRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmTelephoneArray:(NSMutableArray*)alarmTelephoneArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)rfidSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno rfidDeviceArray:(NSArray*)rfidDeviceArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)wirelessAlarmDeviceSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno wirelessAlarmDeviceArray:(NSArray*)wirelessAlarmDeviceArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

+(void)warningSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmMessage:(alarmMessageModel*)alarmMessage delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;

//报警日志
+(void)warningNoteRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno begintime:(NSString*)begintime endtime:(NSString*)endtime delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel;
@end
























