//
//  hostLogoModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "hostLogoModel.h"

@implementation hostLogoModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _hostid = [dictionary objectForKey:@"id"];
        _name = [dictionary objectForKey:@"name"];
    }
    return self;
    
}
@end
