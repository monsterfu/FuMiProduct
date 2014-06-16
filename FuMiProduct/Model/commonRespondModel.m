//
//  commonRespondModel.m
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "commonRespondModel.h"

@implementation commonRespondModel


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _msgcode = [dictionary objectForKey:@"msgcode"];
        _seqno = [dictionary objectForKey:@"seqno"];
        _respcode = [dictionary objectForKey:@"respcode"];
        _respinfo = [dictionary objectForKey:@"respinfo"];
    }
    return self;
    
}
@end
