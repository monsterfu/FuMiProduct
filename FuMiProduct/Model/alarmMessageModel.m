//
//  alarmMessageModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmMessageModel.h"

@implementation alarmMessageModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _type = [dictionary objectForKey:@"type"];
        _deveceid = [dictionary objectForKey:@"id"];
        _name = [dictionary objectForKey:@"name"];
        _time = [dictionary objectForKey:@"time"];
        _content = [dictionary objectForKey:@"content"];
    }
    return self;
    
}

@end
