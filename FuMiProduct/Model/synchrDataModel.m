//
//  synchrDataModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "synchrDataModel.h"

@implementation synchrDataModel

- (id)initWithDictionary:(NSDictionary *)dictionary hostArray:(NSMutableArray*)hostArray alarmDeviceArray:(NSMutableArray*)alarmDeviceArray rfidDeviceArray:(NSMutableArray*)rfidArray
{
    if (self = [super init])
    {
        _msgcode = [dictionary objectForKey:@"msgcode"];
        _seqno = [dictionary objectForKey:@"seqno"];
        _respcode = [dictionary objectForKey:@"respcode"];
        _respinfo = [dictionary objectForKey:@"respinfo"];
        
        NSArray* arr1=[dictionary objectForKey:@"hostattrs"];
        for (NSDictionary*dic in arr1) {
            _hostattrs = [[hostPropertyModel alloc]initWithDictionary:dic];
            [hostArray addObject:_hostattrs];
        }
        
        NSArray* arr2=[dictionary objectForKey:@"alarmdevices"];
        for (NSDictionary*dic in arr2) {
            _alarmdevices = [[wirelessAlarmDeviceModel alloc]initWithDictionary:dic];
            [alarmDeviceArray addObject:_alarmdevices];
        }
        
        NSArray* arr3=[dictionary objectForKey:@"rfiddevices"];
        for (NSDictionary*dic in arr3) {
            _rfiddevices = [[rfidDeviceModel alloc]initWithDictionary:dic];
            [rfidArray addObject:_rfiddevices];
        }
    }
    return self;
    
}

@end
