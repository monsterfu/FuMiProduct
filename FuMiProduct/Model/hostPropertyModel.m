//
//  hostPropertyModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "hostPropertyModel.h"

@implementation hostPropertyModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _hostId = [dictionary objectForKey:@"id"];
        _name = [dictionary objectForKey:@"name"];
        _email = [dictionary objectForKey:@"email"];
        _workstatus = [dictionary objectForKey:@"workstatus"];
        _rspdelay = [dictionary objectForKey:@"rspdelay"];
        _almvolume = [dictionary objectForKey:@"almvolume"];
        _alarmtime = [dictionary objectForKey:@"alarmtime"];
        _retpwdflag = [dictionary objectForKey:@"retpwdflag"];
        _onekeyphone = [dictionary objectForKey:@"onekeyphone"];
        _hostphone = [dictionary objectForKey:@"hostphone"];
        _address = [dictionary objectForKey:@"address"];
        
        
    }
    return self;
    
}

@end
