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
    
//    NSStringEncoding gbkEncoding  =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    [asiRequest appendPostData:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    [asiRequest setUseSessionPersistence:YES];
    [asiRequest setUseCookiePersistence:YES];
    [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [asiRequest setDelegate:delegate];
    [asiRequest setTimeOutSeconds:8.0f];
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
    [request setTimeOutSeconds:8.0f];
    
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
        NSLog(@"baiduKey百度云ID:%@",baiduKey);
    }
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4002\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"passwd\":\"%@\",\"seqno\":\"%@\",\"baiduusrid\":\"%@\"}",mobile,hostid,password,seqno,baiduKey] tag:TAG_LOGIN delegate:delegate finishSel:finishSel failSel:failSel];
}
//
//+(void)synchrDataRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
//    
//    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4002\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\"}",mobile,host,seqno] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
//}

+(void)proportySetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno name:(NSString*)name email:(NSString*)email question:(NSString*)question answer:(NSString*)answer workstatus:(NSString*)workstatus rspdelay:(NSString*)rspdelay almvolume:(NSString*)almvolume alarmtime:(NSString*)alarmtime retpwdflag:(NSString*)retpwdflag onekeyphone:(NSString*)onekeyphone address:(NSString*)address delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel tag:(NSUInteger)tag{
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4003\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"name\":\"%@\",\"email\":\"%@\",\"question\":\"%@\",\"answer\":\"%@\",\"workstatus\":\"%@\",\"rspdelay\":\"%@\",\"almvolume\":\"%@\",\"alarmtime\":\"%@\",\"retpwdflag\":\"%@\",\"onekeyphone\":\"%@\",\"address\":\"%@\"}",mobile,host,seqno,name,email,question,answer,workstatus,rspdelay,almvolume,alarmtime,retpwdflag,onekeyphone,address] tag:tag delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)addAlarmphoneNumRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmTelephoneArray:(NSMutableArray*)alarmTelephoneArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* deviceInfo = @"[";
    for (alarmTelephoneModel* model in alarmTelephoneArray) {
        NSString* device = [NSString stringWithFormat:@"{\"alarmphone\":\"%@\",\"phonetype\":\"%@\",\"opertype\":\"%@\"}",model.alarmphone,model.phonetype,model.opertype];
        deviceInfo = [deviceInfo stringByAppendingString:device];
        deviceInfo = [deviceInfo stringByAppendingString:@","];
    }
    deviceInfo = [deviceInfo stringByAppendingString:@"]"];
    
//    NSString* alarmPhone = [NSString stringWithFormat:@"[{\"alarmphone\":\"%@\",\"phonetype\":\"%@\",\"opertype\":\"%@\"}]",alarmTelephone.alarmphone,alarmTelephone.phonetype,alarmTelephone.opertype];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4004\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"alarmphones\":%@}",mobile,host,seqno,deviceInfo] tag:TAG_ALARMPHONE_EDIT delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)rfidSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno rfidDeviceArray:(NSArray*)rfidDeviceArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* deviceInfo = @"[";
    for (rfidDeviceModel* model in rfidDeviceArray) {
        NSString* device = [NSString stringWithFormat:@"[{\"id\":\"%@\",\"name\":\"%@\",\"opertype\":\"%@\"}]",model.deveceid,model.name,model.opertype];
        deviceInfo = [deviceInfo stringByAppendingString:device];
        deviceInfo = [deviceInfo stringByAppendingString:@","];
    }
    deviceInfo = [deviceInfo stringByAppendingString:@"]"];
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4005\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"RFIDdevices\":%@}",mobile,host,seqno,deviceInfo] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)wirelessAlarmDeviceSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno wirelessAlarmDeviceArray:(NSArray*)wirelessAlarmDeviceArray delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* deviceInfo = @"[";
    for (wirelessAlarmDeviceModel* model in wirelessAlarmDeviceArray) {
        NSString* device = [NSString stringWithFormat:@"{\"type\":\"%@\",\"deveceid\":\"%@\",\"name\":\"%@\",\"status\":\"%@\",\"opertype\":\"%@\",\"id\":\"%@\"}",model.type,model.deveceid,model.name,model.status,model.opertype,model.deveceid];
        deviceInfo = [deviceInfo stringByAppendingString:device];
        deviceInfo = [deviceInfo stringByAppendingString:@","];
    }
    deviceInfo = [deviceInfo stringByAppendingString:@"]"];
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4006\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"alarmdevices\":%@}",mobile,host,seqno,deviceInfo] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)warningSetRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno alarmMessage:(alarmMessageModel*)alarmMessage delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    NSString* message = [NSString stringWithFormat:@"[{\"type\":\"%@\",\"deveceid\":\"%@\",\"name\":\"%@\"}]",alarmMessage.type,alarmMessage.deveceid,alarmMessage.name];
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"4007\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"alarmmessage\":%@}",mobile,host,seqno,message] tag:0 delegate:delegate finishSel:finishSel failSel:failSel];
}

+(void)warningNoteRequest:(NSString*)mobile host:(NSString*)host seqno:(NSString*)seqno begintime:(NSString*)begintime endtime:(NSString*)endtime delegate:(id)delegate finishSel:(SEL)finishSel failSel:(SEL)failSel{
    
    [self Request:BASE postdate:[NSString stringWithFormat:@"{\"msgcode\":\"0016\",\"mobile\":\"%@\",\"hostid\":\"%@\",\"seqno\":\"%@\",\"begintime\":%@,\"endtime\":%@}",mobile,host,seqno,begintime,endtime] tag:TAG_WARNINGNOTE delegate:delegate finishSel:finishSel failSel:failSel];
}
@end









