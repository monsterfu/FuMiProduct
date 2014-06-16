//
//  wirelessAlarmDeviceModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "wirelessAlarmDeviceModel.h"

@implementation wirelessAlarmDeviceModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _type = [dictionary objectForKey:@"type"];
        _deveceid = [dictionary objectForKey:@"id"];
        _name = [dictionary objectForKey:@"name"];
        _status = [dictionary objectForKey:@"status"];
        _opertype = [dictionary objectForKey:@"opertype"];
    }
    return self;
    
}

@end
