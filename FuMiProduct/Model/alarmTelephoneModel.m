//
//  alarmTelephoneModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmTelephoneModel.h"

@implementation alarmTelephoneModel
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _alarmphone = [dictionary objectForKey:@"alarmphone"];
        _phonetype = [dictionary objectForKey:@"phonetype"];
        _opertype = [dictionary objectForKey:@"opertype"];
    }
    return self;
    
}
@end
