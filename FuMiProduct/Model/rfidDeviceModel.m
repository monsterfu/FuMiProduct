//
//  rfidDeviceModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "rfidDeviceModel.h"

@implementation rfidDeviceModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _deveceid = [dictionary objectForKey:@"id"];
        _name = [dictionary objectForKey:@"name"];
        _opertype = [dictionary objectForKey:@"opertype"];
    }
    return self;
    
}

@end
