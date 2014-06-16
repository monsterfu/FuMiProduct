//
//  synchrDataModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hostPropertyModel.h"
#import "wirelessAlarmDeviceModel.h"
#import "rfidDeviceModel.h"

@interface synchrDataModel : NSObject
@property(nonatomic,strong)NSString* msgcode;
@property(nonatomic,strong)NSString* seqno;
@property(nonatomic,strong)NSString* respcode;
@property(nonatomic,strong)NSString* respinfo;
@property(nonatomic,strong)hostPropertyModel* hostattrs;
@property(nonatomic,strong)wirelessAlarmDeviceModel* alarmdevices;
@property(nonatomic,strong)rfidDeviceModel* rfiddevices;

- (id)initWithDictionary:(NSDictionary *)dictionary hostArray:(NSMutableArray*)hostArray alarmDeviceArray:(NSMutableArray*)alarmDeviceArray rfidDeviceArray:(NSMutableArray*)rfidArray;
@end
