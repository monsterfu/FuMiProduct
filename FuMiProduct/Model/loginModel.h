//
//  loginModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hostPropertyModel.h"
#import "wirelessAlarmDeviceModel.h"
#import "rfidDeviceModel.h"
#import "alarmTelephoneModel.h"

@interface loginModel : NSObject

@property(nonatomic,strong)NSString* msgcode;
@property(nonatomic,strong)NSString* seqno;
@property(nonatomic,strong)NSString* respcode;
@property(nonatomic,strong)NSString* respinfo;
@property(nonatomic,strong)hostPropertyModel* hostattrs;
@property(nonatomic,strong)wirelessAlarmDeviceModel* alarmdevices;
@property(nonatomic,strong)rfidDeviceModel* rfiddevices;
@property(nonatomic,strong)alarmTelephoneModel* alarmPhoneModel;

- (id)initWithDictionary:(NSDictionary *)dictionary hostArray:(NSMutableArray*)hostArray alarmDeviceArray:(NSMutableArray*)alarmDeviceArray rfidDeviceArray:(NSMutableArray*)rfidArray alarmPhoneArray:(NSMutableArray*)alarmPhoneArray;
@end
