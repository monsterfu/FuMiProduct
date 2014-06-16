//
//  hostPropertyModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hostPropertyModel : NSObject

@property(nonatomic,strong)NSString* hostId;        //主机id
@property(nonatomic,strong)NSString* name;          //主机别名
@property(nonatomic,strong)NSString* email;         //机主邮箱
@property(nonatomic,strong)NSString* workstatus;    //工作状态
@property(nonatomic,strong)NSString* rspdelay;      //响应时延
@property(nonatomic,strong)NSString* almvolume;     //报警音量
@property(nonatomic,strong)NSString* alarmtime;     //报警持续 时间
@property(nonatomic,strong)NSString* retpwdflag;    //撤防密码 标识
@property(nonatomic,strong)NSString* onekeyphone;   //一键通话 号码
@property(nonatomic,strong)NSString* hostphone;     //主机手机 号码
@property(nonatomic,strong)NSString* address;       //主机地址

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
