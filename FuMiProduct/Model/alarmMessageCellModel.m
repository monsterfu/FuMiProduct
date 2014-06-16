//
//  alarmMessageCellModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmMessageCellModel.h"

@implementation alarmMessageCellModel


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _time = [dictionary objectForKey:@"time"];
        _content = [dictionary objectForKey:@"content"];
    }
    return self;
    
}
@end
