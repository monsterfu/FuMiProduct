//
//  HttpRequest.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "HttpRequest.h"
#import "GlobalHeader.h"
#import "AppDelegate.h"


@implementation HttpRequest
+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSLog(@"url is %@",url);
    NSLog(@"%@ ---------%d",postdata,tag);
    NSURL *httpurl = [NSURL URLWithString:url];
    
    ASIHTTPRequest* asiRequest = [ASIHTTPRequest requestWithURL:httpurl];
    
    [asiRequest setTag:tag];
    
    [asiRequest setRequestMethod:@"POST"];
    [asiRequest appendPostData:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    [asiRequest setUseSessionPersistence:NO];
    [asiRequest setUseCookiePersistence:NO];
    [asiRequest setTimeOutSeconds:3.0f];
    [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [asiRequest setDelegate:delegate];
    
    [asiRequest setDidFinishSelector:finishSel];
    [asiRequest setDidFailSelector:failSel];
    [asiRequest startAsynchronous];
    
}

+(void)Request:(NSString*)url postdate:(NSString*)postdata tag:(int)tag request:(ASIHTTPRequest *)request delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSLog(@"url is %@",url);
    NSLog(@"%@ ---------%d",postdata,tag);
//    NSURL *httpurl = [NSURL URLWithString:url];
    
//    request = [ASIHTTPRequest requestWithURL:httpurl];
    
    [request setTag:tag];
    [request appendPostData:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    [request setUseSessionPersistence:YES];
    [request setUseCookiePersistence:YES];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:delegate];
    [request setTimeOutSeconds:3.0f];
    
    [request setDidFinishSelector:finishSel];
    [request setDidFailSelector:failSel];
    [request startAsynchronous];
}

+(void)fetchHostRequest:(NSString*)mobile seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4001\",\"mobile\":\"%@\",\"seqno\":\"%@\",\"appOS\":\"02\"}",mobile,seqno] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)LoginRequest:(NSString*)mobile password:(NSString*)password hostId:(NSString*)hostid seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    NSString* baiduKey = @"";
    if ([USER_DEFAULT objectForKey:BPushRequestUserIdKey]) {
        baiduKey = [USER_DEFAULT objectForKey:BPushRequestUserIdKey];
    }
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4002\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"passwd\":\"%@\",\"seqno\":\"%@\",\"baiduusrid\":\"%@\"}",mobile,hostid,password,seqno,baiduKey] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}
//
//+(void)synchrDataRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
//    
//    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4002\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\"}",mobile,host,seqno] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
//}

+(void)proportySetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno name:(NSString*)name email:(NSString*)email question:(NSString*)question answer:(NSString*)answer workstatus:(NSString*)workstatus rspdelay:(NSString*)rspdelay almvolume:(NSString*)almvolume alarmtime:(NSString*)alarmtime retpwdflag:(NSString*)retpwdflag onekeyphone:(NSString*)onekeyphone address:(NSString*)address delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel tag:(NSUInteger)tag{
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4003\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"name\":\"%@\",\"email\":\"%@\",\"question\":\"%@\",\"answer\":\"%@\",\"workstatus\":\"%@\",\"rspdelay\":\"%@\",\"almvolume\":\"%@\",\"alarmtime\":\"%@\",\"retpwdflag\":\"%@\",\"onekeyphone\":\"%@\",\"address\":\"%@\"}",mobile,host,seqno,name,email,question,answer,workstatus,rspdelay,almvolume,alarmtime,retpwdflag,onekeyphone,address] tag:tag delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)addAlarmphoneNumRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmTelephone:(alarmTelephoneModel*)alarmTelephone delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* alarmPhone = [NSString stringWithFormat:@"[{\"alarmphone\":\"%@\",\"phonetype\":\"%@\",\"opertype\":\"%@\"}]",alarmTelephone.alarmphone,alarmTelephone.phonetype,alarmTelephone.opertype];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4004\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"alarmphones\":%@}",mobile,host,seqno,alarmPhone] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)rfidSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno rfidDevice:(rfidDeviceModel*)rfidDevice delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* device = [NSString stringWithFormat:@"[{\"id\":\"%@\",\"name\":\"%@\",\"opertype\":\"%@\"}]",rfidDevice.deveceid,rfidDevice.name,rfidDevice.opertype];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4005\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"rfiddevices\":%@}",mobile,host,seqno,device] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)wirelessAlarmDeviceSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno wirelessAlarmDevice:(wirelessAlarmDeviceModel*)wirelessAlarmDevice delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* device = [NSString stringWithFormat:@"[{\"type\":\"%@\",\"deveceid\":\"%@\",\"name\":\"%@\",\"status\":\"%@\",\"opertype\":\"%@\"}]",wirelessAlarmDevice.type,wirelessAlarmDevice.deveceid,wirelessAlarmDevice.name,wirelessAlarmDevice.status,wirelessAlarmDevice.opertype];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4006\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"rfiddevices\":%@}",mobile,host,seqno,device] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)warningSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmMessage:(alarmMessageModel*)alarmMessage delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* message = [NSString stringWithFormat:@"[{\"type\":\"%@\",\"deveceid\":\"%@\",\"name\":\"%@\"}]",alarmMessage.type,alarmMessage.deveceid,alarmMessage.name];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4007\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"alarmmessage\":%@}",mobile,host,seqno,message] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)warningNoteRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno begintime:(NSString*)begintime endtime:(NSString*)endtime delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"0016\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"begintime\":%@,\"endtime\":%@}",mobile,host,seqno,begintime,endtime] tag:TAG_WARNINGNOTE delegate:delegate finishSel:finishSel failSel:failSel];
}
@end









